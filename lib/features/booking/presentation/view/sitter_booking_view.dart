import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/booking/domain/entity/booking_entity.dart';
import 'package:pawpal/features/booking/presentation/view_model/bookings_bloc.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: BlocBuilder<BookingsBloc, BookingState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Text(
                'Error: ${state.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (state.bookings.isEmpty) {
            return const Center(child: Text('No bookings available.'));
          }

          return ListView.builder(
            itemCount: state.bookings.length,
            itemBuilder: (context, index) {
              final BookingEntity booking = state.bookings[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text('Booking ID: ${booking.bookingId}'),
                  subtitle: Text(
                    'Pet ID: ${booking.petId}\n'
                    'Start Date: ${booking.startDate}\n'
                    'End Date: ${booking.endDate}\n'
                    'Status: ${booking.status}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context
                          .read<BookingsBloc>()
                          .add(DeleteBooking(bookingId: booking.bookingId!));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
