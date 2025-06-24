package com.salonbooking.full.service;

import com.salonbooking.full.model.Payment;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

public interface PaymentService {
    Payment processPayment(Payment payment) throws IOException;
    List<Payment> getAllPayments() throws IOException;
    Optional<Payment> getPaymentById(String id) throws IOException;
    Optional<Payment> getPaymentByAppointmentId(String appointmentId) throws IOException;
    List<Payment> getPaymentsByUserId(String userId) throws IOException;
    void deletePayment(String id) throws IOException;
    Payment refundPayment(String id) throws IOException;
}
