function validateRegister() {
  var pw = document.querySelector('input[name="password"]').value;
  if (pw.length < 6) {
    alert('Password must be at least 6 characters');
    return false;
  }
  return true;
}
