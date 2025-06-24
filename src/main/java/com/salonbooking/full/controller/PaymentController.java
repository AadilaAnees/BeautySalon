package com.salonbooking.full.controller;

import com.salonbooking.full.model.Appointment;
import com.salonbooking.full.model.Payment;
import com.salonbooking.full.model.User;
import com.salonbooking.full.service.AppointmentService;
import com.salonbooking.full.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.time.LocalDateTime; // Add this import


@Controller
public class PaymentController {

    private final PaymentService paymentService;
    private final AppointmentService appointmentService;

    @Autowired
    public PaymentController(PaymentService paymentService, AppointmentService appointmentService) {
        this.paymentService = paymentService;
        this.appointmentService = appointmentService;
    }

    // Client payment pages

    @GetMapping("/client/payment")
    public String paymentForm(HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        // Create a new payment object
        Payment payment = new Payment();
        payment.setUserId(client.getId());
        payment.setUserName(client.getUsername());

        model.addAttribute("payment", payment);
        model.addAttribute("clientId", client.getId());

        return "client/payment-form";
    }

    @PostMapping("/client/payment/process")
    public String processPayment(@ModelAttribute Payment payment,
                                 @RequestParam String serviceId,
                                 @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate appointmentDate,
                                 @RequestParam String appointmentTime,
                                 @RequestParam(required = false) String notes,
                                 @RequestParam String paymentMethod,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            System.out.println("===== PROCESS PAYMENT DEBUG =====");
            System.out.println("Payment method: " + paymentMethod);
            System.out.println("Service ID: " + serviceId);
            System.out.println("Appointment Date: " + appointmentDate);
            System.out.println("Appointment Time: " + appointmentTime);

            // Set up payment details
            payment.setUserId(client.getId());
            payment.setUserName(client.getUsername());
            payment.setPaymentMethod(paymentMethod);

            System.out.println("Payment object before processing: " + payment.toString());

            // For cash payments, set status to PENDING
            if ("CASH".equals(paymentMethod)) {
                payment.setStatus("PENDING");
            } else {
                // For card payments, validate card details
                if (payment.getCardNumber() == null || payment.getCardNumber().trim().isEmpty()) {
                    throw new IllegalArgumentException("Card number is required for card payments");
                }

                if (payment.getCardHolderName() == null || payment.getCardHolderName().trim().isEmpty()) {
                    throw new IllegalArgumentException("Card holder name is required for card payments");
                }

                payment.setStatus("COMPLETED");
            }

            // Process the payment
            Payment processedPayment = paymentService.processPayment(payment);
            System.out.println("Processed payment: ID=" + processedPayment.getId());

            // Now book the appointment
            LocalTime time = LocalTime.parse(appointmentTime);

            Appointment appointment = new Appointment();
            appointment.setUserId(client.getId());
            appointment.setUserName(client.getUsername());
            appointment.setServiceId(serviceId);
            appointment.setServiceName(payment.getServiceName());
            appointment.setAppointmentDate(appointmentDate);
            appointment.setAppointmentTime(time);
            appointment.setPrice(payment.getAmount());
            appointment.setNotes(notes);

            // For cash payments, set appointment status to CONFIRMED but not PAID
            // For card payments, set to CONFIRMED
            appointment.setStatus("CONFIRMED");

            Appointment savedAppointment = appointmentService.saveAppointment(appointment);
            System.out.println("Saved appointment: ID=" + savedAppointment.getId());

            // Update the payment with the appointment ID
            processedPayment.setAppointmentId(savedAppointment.getId());
            paymentService.processPayment(processedPayment);
            System.out.println("Updated payment with appointment ID");

            // Set success message
            String successMessage = "CASH".equals(paymentMethod)
                    ? "Your appointment has been booked successfully! Please pay at the salon."
                    : "Your payment has been processed successfully and your appointment is confirmed!";
            redirectAttributes.addFlashAttribute("success", successMessage);

            // Redirect to client appointments page
            return "redirect:/client/appointments";

        } catch (Exception e) {
            System.out.println("ERROR in processPayment: " + e.getMessage());
            e.printStackTrace(); // Print the stack trace for debugging
            redirectAttributes.addFlashAttribute("error", "Payment failed: " + e.getMessage());
            return "redirect:/client/payment";
        }
    }

    @GetMapping("/client/payment/invoice/{id}")
    public String viewInvoice(@PathVariable String id, HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            Optional<Payment> payment = paymentService.getPaymentById(id);
            if (!payment.isPresent() || !payment.get().getUserId().equals(client.getId())) {
                return "redirect:/client/appointments";
            }

            model.addAttribute("payment", payment.get());

            // Get appointment details
            Optional<Appointment> appointment = appointmentService.getAppointmentById(payment.get().getAppointmentId());
            if (appointment.isPresent()) {
                model.addAttribute("appointment", appointment.get());
            }

            return "client/invoice";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load invoice: " + e.getMessage());
            return "redirect:/client/appointments";
        }
    }

    @GetMapping("/client/payments")
    public String clientPayments(HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            List<Payment> payments = paymentService.getPaymentsByUserId(client.getId());
            model.addAttribute("payments", payments);
            return "client/payments";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load payments: " + e.getMessage());
            return "client/payments";
        }
    }

    // Admin payment pages

    @GetMapping("/admin/payments")
    public String adminPayments(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            List<Payment> allPayments = paymentService.getAllPayments();
            System.out.println("All payments size: " + allPayments.size());

            for (Payment p : allPayments) {
                System.out.println("Payment found: ID=" + p.getId()
                        + ", Method=" + p.getPaymentMethod()
                        + ", Status=" + p.getStatus()
                        + ", Amount=" + p.getAmount()
                        + ", AppointmentID=" + p.getAppointmentId());
            }

            // Print payment methods for debugging
            allPayments.forEach(p -> System.out.println("Payment ID: " + p.getId() +
                    ", Method: " + p.getPaymentMethod() +
                    ", Status: " + p.getStatus()));


            // Separate payments into card and cash
            List<Payment> cardPayments = allPayments.stream()
                    .filter(p -> p.getPaymentMethod() != null && p.getPaymentMethod().equalsIgnoreCase("CARD"))
                    .collect(Collectors.toList());

            List<Payment> cashPayments = allPayments.stream()
                    .filter(p -> p.getPaymentMethod() != null && p.getPaymentMethod().equalsIgnoreCase("CASH"))
                    .collect(Collectors.toList());

            // Add this debugging code here
            System.out.println("Card payments size: " + cardPayments.size());
            System.out.println("Cash payments size: " + cashPayments.size());

            model.addAttribute("cardPayments", cardPayments);
            model.addAttribute("cashPayments", cashPayments);

            if (cardPayments.isEmpty() && cashPayments.isEmpty()) {
                // Create a test card payment
                Payment testCardPayment = new Payment();
                testCardPayment.setId("TEST-CARD-1");
                testCardPayment.setAppointmentId("APP-123");
                testCardPayment.setAmount(100.0);
                testCardPayment.setPaymentMethod("CARD");
                testCardPayment.setStatus("COMPLETED");
                testCardPayment.setPaymentDate(LocalDateTime.now());
                testCardPayment.setCardNumber("****1234");
                testCardPayment.setServiceName("Haircut");

                // Create a test cash payment
                Payment testCashPayment = new Payment();
                testCashPayment.setId("TEST-CASH-1");
                testCashPayment.setAppointmentId("APP-456");
                testCashPayment.setAmount(80.0);
                testCashPayment.setPaymentMethod("CASH");
                testCashPayment.setStatus("PENDING");
                testCashPayment.setPaymentDate(LocalDateTime.now());
                testCashPayment.setServiceName("Manicure");

                // Override model attributes with test data
                model.addAttribute("cardPayments", Collections.singletonList(testCardPayment));
                model.addAttribute("cashPayments", Collections.singletonList(testCashPayment));

                System.out.println("Added test payment data to model");
            }

            return "admin/payments";
        } catch (IOException e) {
            System.out.println("ERROR loading payments: " + e.getMessage());
            e.printStackTrace(); // Print the stack trace for debugging
            model.addAttribute("error", "Failed to load payments: " + e.getMessage());
            return "admin/payments";
        }

    }

    @GetMapping("/admin/payment/delete/{id}")
    public String deletePayment(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            paymentService.deletePayment(id);
            redirectAttributes.addFlashAttribute("success", "Payment deleted successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete payment: " + e.getMessage());
        }
        return "redirect:/admin/payments";
    }

    @GetMapping("/admin/payment/refund/{id}")
    public String refundPayment(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            paymentService.refundPayment(id);
            redirectAttributes.addFlashAttribute("success", "Payment refunded successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to refund payment: " + e.getMessage());
        }
        return "redirect:/admin/payments";
    }

    @GetMapping("/admin/payment/invoice/{id}")
    public String adminViewInvoice(@PathVariable String id, HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            Optional<Payment> payment = paymentService.getPaymentById(id);
            if (!payment.isPresent()) {
                return "redirect:/admin/payments";
            }

            model.addAttribute("payment", payment.get());

            // Get appointment details
            Optional<Appointment> appointment = appointmentService.getAppointmentById(payment.get().getAppointmentId());
            if (appointment.isPresent()) {
                model.addAttribute("appointment", appointment.get());
            }

            return "admin/invoice";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load invoice: " + e.getMessage());
            return "redirect:/admin/payments";
        }

    }
    @PostMapping("/admin/mark-as-paid")
    public String markAsPaid(@RequestParam String paymentId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            Optional<Payment> optPayment = paymentService.getPaymentById(paymentId);
            if (optPayment.isPresent()) {
                Payment payment = optPayment.get();
                payment.setStatus("COMPLETED");
                paymentService.processPayment(payment);
                redirectAttributes.addFlashAttribute("success", "Payment marked as paid successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "Payment not found");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to mark payment as paid: " + e.getMessage());
        }
        return "redirect:/admin/payments";
    }

    @PostMapping("/admin/delete-payment")
    public String deletePaymentPost(@RequestParam String paymentId,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            paymentService.deletePayment(paymentId);
            redirectAttributes.addFlashAttribute("success", "Payment deleted successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete payment: " + e.getMessage());
        }
        return "redirect:/admin/payments";
    }
}
