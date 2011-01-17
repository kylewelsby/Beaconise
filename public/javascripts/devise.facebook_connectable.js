/**
 *  JavaScript Helpers for devise_facebook_connectable,
 *  to make sign in/out (connect) with Devise seamless.
 *
 *  Note: JavaScript framework agnostic.
 */

if (typeof devise === 'undefined' || devise === null) {
  devise = {};
}

if (typeof devise.facebook_connectable === 'undefined' || devise.facebook_connectable === null) {
  devise.facebook_connectable = {};
}

/*
 *  Connect/Login.
 */
devise.facebook_connectable.sign_in = function fbc_sign_in(appID, scopes) {
  var href = document.getElementById('fb_connect_sign_in_form').url;
	document.location.href = "https://graph.facebook.com/oauth/authorize?client_id='+appID+'&redirect_uri='+href+'&scope='+scopes+'&display=page";
  return false;
};

/*
 *  Connect/Login - with callback.
 */
devise.facebook_connectable.sign_in_with_callback = function fbc_sign_in_with_callback(appID) {
  FB.Connect.requireSession(devise.facebook_connectable.sign_in(appID));
  return false;
};

/*
 *  Logout.
 */
devise.facebook_connectable.sign_out = function fbc_sign_out() {
  document.getElementById('fb_connect_sign_out_form').submit();
  return false;
};

/*
 *  Logout - with callback.
 */
devise.facebook_connectable.sign_out_with_callback = function fbc_sign_out_with_callback() {
  FB.Connect.logout(devise.facebook_connectable.sign_out);
  return false;
};

/*
 *  TODO: Logout.
 */
devise.facebook_connectable.disconnect = function fbc_disconnect() {
  // TODO: Implement
  return false;
};

/*
 *  TODO: Disconnect - with callback.
 */
devise.facebook_connectable.disconnect_with_callback = function fbc_disconnect_with_callback() {
  // FIXME: FB.api don't seems to be loaded correctly - Facebooker issue?
  // FB.api({method: 'Auth.revokeAuthorization'}, devise.facebook_connectable.disconnect);
  return false;
};
