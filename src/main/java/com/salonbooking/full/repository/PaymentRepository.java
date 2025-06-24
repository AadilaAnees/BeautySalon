package com.salonbooking.full.repository;

import com.salonbooking.full.model.Payment;
import com.salonbooking.full.util.FileUtil;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
public class PaymentRepository {
    private static final String PAYMENTS_FILE = "payments.txt";

    public Payment save(Payment payment) throws IOException {
        if (payment.getId() == null || payment.getId().isEmpty()) {
            // Generate a simple numeric ID
            List<Payment> existingPayments = findAll();

            int maxId = 0;
            for (Payment existingPayment : existingPayments) {
                try {
                    int id = Integer.parseInt(existingPayment.getId());
                    if (id > maxId) {
                        maxId = id;
                    }
                } catch (NumberFormatException e) {
                    // Skip non-numeric IDs
                }
            }

            payment.setId(String.valueOf(maxId + 1));
        }

        // Set payment date if not already set
        if (payment.getPaymentDate() == null) {
            payment.setPaymentDate(LocalDateTime.now());
        }

        List<Payment> payments = findAll();

        // Remove existing payment if updating
        payments = payments.stream()
                .filter(p -> !p.getId().equals(payment.getId()))
                .collect(Collectors.toList());

        // Add the new/updated payment
        payments.add(payment);

        // Save all payments back to file
        FileUtil.writeToFile(PAYMENTS_FILE, payments.stream()
                .map(Payment::toString)
                .collect(Collectors.toList()));

        return payment;
    }

    public List<Payment> findAll() throws IOException {
        List<String> lines = FileUtil.readFromFile(PAYMENTS_FILE);
        System.out.println("========== PAYMENT REPOSITORY DEBUG ==========");
        System.out.println("Read " + lines.size() + " lines from payments file");
        List<Payment> payments = new ArrayList<>();

        for (String line : lines) {
            Payment payment = Payment.fromString(line);
            if (payment != null) {
                payments.add(payment);
                System.out.println("Parsed payment: ID=" + payment.getId() +
                        ", Method=" + payment.getPaymentMethod() +
                        ", Status=" + payment.getStatus());
            } else {
                System.out.println("Failed to parse payment line: " + line);
            }
        }

        // Sort by payment date (most recent first)
        payments.sort(Comparator.comparing(Payment::getPaymentDate, Comparator.nullsLast(Comparator.reverseOrder())));

        System.out.println("Returning " + payments.size() + " payments");

        return payments;
    }

    public Optional<Payment> findById(String id) throws IOException {
        return findAll().stream()
                .filter(payment -> payment.getId().equals(id))
                .findFirst();
    }

    public Optional<Payment> findByAppointmentId(String appointmentId) throws IOException {
        return findAll().stream()
                .filter(payment -> payment.getAppointmentId().equals(appointmentId))
                .findFirst();
    }

    public List<Payment> findByUserId(String userId) throws IOException {
        return findAll().stream()
                .filter(payment -> payment.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    public void deleteById(String id) throws IOException {
        List<Payment> payments = findAll();

        // Remove the payment with the given ID
        payments = payments.stream()
                .filter(p -> !p.getId().equals(id))
                .collect(Collectors.toList());

        // Save the updated list back to file
        FileUtil.writeToFile(PAYMENTS_FILE, payments.stream()
                .map(Payment::toString)
                .collect(Collectors.toList()));
    }
}
