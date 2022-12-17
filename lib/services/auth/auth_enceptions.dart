// Login route excemtions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// register route exceptions
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// Generic Exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
