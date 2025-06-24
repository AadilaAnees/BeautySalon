package com.salonbooking.full.service;

import com.salonbooking.full.model.Payment;
import com.salonbooking.full.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class PaymentServiceImpl implements PaymentService {

    private final PaymentRepository paymentRepository;

    @Autowired
    public PaymentServiceImpl(PaymentRepository paymentRepository) {
        this.paymentRepository = paymentRepository;
    }

    @Override
    public Payment processPayment(Payment payment) throws IOException {
        // Validate payment
        if (payment.getAmount() <= 0) {
            throw new IllegalArgumentException("Payment amount must be greater than zero");
        }

        // Set default values if not provided
        if (payment.getPaymentMethod() == null) {
            if (payment.getCardNumber() != null && !payment.getCardNumber().isEmpty()) {
                payment.setPaymentMethod("CARD");
            } else {
                payment.setPaymentMethod("CASH");
            }
        }

        // For card payments, validate card info and set status to COMPLETED if not specified
        if ("CARD".equals(payment.getPaymentMethod())) {
            if (payment.getCardNumber() == null || payment.getCardNumber().trim().isEmpty()) {
                throw new IllegalArgumentException("Card number is required for card payments");
            }

            if (payment.getCardHolderName() == null || payment.getCardHolderName().trim().isEmpty()) {
                throw new IllegalArgumentException("Card holder name is required for card payments");
            }

            if (payment.getStatus() == null || payment.getStatus().isEmpty()) {
                payment.setStatus("COMPLETED");
            }
        } else if ("CASH".equals(payment.getPaymentMethod())) {
            // For cash payments, set status to PENDING if not specified
            if (payment.getStatus() == null || payment.getStatus().isEmpty()) {
                payment.setStatus("PENDING");
            }
        }

        // Set payment date if not already set
        if (payment.getPaymentDate() == null) {
            payment.setPaymentDate(LocalDateTime.now());
        }

        // Save the payment record
        return paymentRepository.save(payment);
    }

    @Override
    public List<Payment> getAllPayments() throws IOException {
        return paymentRepository.findAll();
    }

    @Override
    public Optional<Payment> getPaymentById(String id) throws IOException {
        return paymentRepository.findById(id);
    }

    @Override
    public Optional<Payment> getPaymentByAppointmentId(String appointmentId) throws IOException {
        return paymentRepository.findByAppointmentId(appointmentId);
    }

    @Override
    public List<Payment> getPaymentsByUserId(String userId) throws IOException {
        return paymentRepository.findByUserId(userId);
    }

    @Override
    public void deletePayment(String id) throws IOException {
        paymentRepository.deleteById(id);
    }

    @Override
    public Payment refundPayment(String id) throws IOException {
        Optional<Payment> optionalPayment = paymentRepository.findById(id);
        if (!optionalPayment.isPresent()) {
            throw new IllegalArgumentException("Payment not found");
        }

        Payment payment = optionalPayment.get();

        // Check if payment is already refunded
        if ("REFUNDED".equals(payment.getStatus())) {
            throw new IllegalArgumentException("Payment has already been refunded");
        }

        // Update payment status
        payment.setStatus("REFUNDED");

        // In a real application, you would process the refund through a payment gateway here

        // Save the updated payment
        return paymentRepository.save(payment);
    }
}
