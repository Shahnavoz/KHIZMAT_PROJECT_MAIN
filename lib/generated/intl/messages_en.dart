// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(registrationDate) =>
      "Registration Date: ${registrationDate}";

  static String m1(position, count) => "Step ${position} of ${count}";

  static String m2(count) => "${count} services";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "InPaymentProcess": MessageLookupByLibrary.simpleMessage(
      "In the process of payment",
    ),
    "active": MessageLookupByLibrary.simpleMessage("Active"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "allApplications": MessageLookupByLibrary.simpleMessage("Applications"),
    "allCategories": MessageLookupByLibrary.simpleMessage("All categories"),
    "allDocuments": MessageLookupByLibrary.simpleMessage("All documents"),
    "applicationWasWithdrawn": MessageLookupByLibrary.simpleMessage(
      "Application was withdrawn",
    ),
    "applications": MessageLookupByLibrary.simpleMessage("Applications"),
    "bottom_text": MessageLookupByLibrary.simpleMessage(
      "© 2024-2025 JSC \"Certification Centers, Public Services and Digital Software Development\"",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "cherez_imzo": MessageLookupByLibrary.simpleMessage(
      "To access the mobile app, log in using the IMZO service.",
    ),
    "documents": MessageLookupByLibrary.simpleMessage("Documents"),
    "favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "filtereddocumentsindexregistrationdate": m0,
    "gosOrganizations": MessageLookupByLibrary.simpleMessage(
      "Government organizations",
    ),
    "hasExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "inFillingProcess": MessageLookupByLibrary.simpleMessage(
      "In the process of filling",
    ),
    "inFillingProcessStep": m1,
    "main": MessageLookupByLibrary.simpleMessage("Main"),
    "myApplications": MessageLookupByLibrary.simpleMessage("My applications"),
    "myDocuments": MessageLookupByLibrary.simpleMessage("My Documents"),
    "naRasmotrenii": MessageLookupByLibrary.simpleMessage("Under review"),
    "ne_udayotsa_voyti": MessageLookupByLibrary.simpleMessage("Can\'t log in?"),
    "noApplication": MessageLookupByLibrary.simpleMessage("No applications"),
    "noDocuments": MessageLookupByLibrary.simpleMessage("No documents"),
    "noServices": MessageLookupByLibrary.simpleMessage("No services"),
    "notAssigned": MessageLookupByLibrary.simpleMessage("Not signed"),
    "notFoundOrgs": MessageLookupByLibrary.simpleMessage(
      "Organizations not found",
    ),
    "nothingFound": MessageLookupByLibrary.simpleMessage("Nothing found"),
    "orgdocumentscount": m2,
    "osnovniye_voprosi": MessageLookupByLibrary.simpleMessage("Main questions"),
    "podrobnee": MessageLookupByLibrary.simpleMessage("In detail"),
    "poisk_uslug": MessageLookupByLibrary.simpleMessage("Search for services"),
    "poluchay_uslugi_ne_vikhodya_iz_doma": MessageLookupByLibrary.simpleMessage(
      "Get services without leaving your home",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "proizvesti_vkhod": MessageLookupByLibrary.simpleMessage(
      "Log in to the app",
    ),
    "rejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "reviewPeriodExpired": MessageLookupByLibrary.simpleMessage(
      "Review period expired",
    ),
    "ru": MessageLookupByLibrary.simpleMessage("RU"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchDocsAndApplications": MessageLookupByLibrary.simpleMessage(
      "Search documents and applications",
    ),
    "searchOrganization": MessageLookupByLibrary.simpleMessage(
      "Search organizations",
    ),
    "seenSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Successfully reviewed",
    ),
    "serviceCategories": MessageLookupByLibrary.simpleMessage(
      "Service categories",
    ),
    "services": MessageLookupByLibrary.simpleMessage("Services"),
    "startSearching": MessageLookupByLibrary.simpleMessage("Start searching!"),
    "svernut": MessageLookupByLibrary.simpleMessage("Collapse"),
    "voyti_cherez_imzo": MessageLookupByLibrary.simpleMessage(
      "Log in with IMZO",
    ),
  };
}
