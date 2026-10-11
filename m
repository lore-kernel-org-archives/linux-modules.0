Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BF44F56D;
	Sun, 11 Oct 2026 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723193; cv=none; b=KImdQp0hA37D2DtsXwMzbqPuyHNWBoEOn+EE7INsxMNsJRFd14OUbDgS+9IfHrRgUyOdhXcKOj52IQe1JXvvb8v7vRkWKd0AKu6eTWr6QhX3+v4q17F7tu4YaTALuFxSOcGx9VVMhng14/x56B4bni9SKSq64C1s31J9zmhoWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723193; c=relaxed/simple;
	bh=zgjalkyaZN7cUZOI3jfW3Rc23Mnum25IcbZ9KTZSQyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ci1xM+/Rt22YrMFH4xN/KoEZwQuuPN/NZPZon5+hSnjxJo2NpZ19XXp655jistSoYlN9aQ+5olRD7JdIXD9AUfdyW6Bj0lNkmdYrxKcGYoWXmlslC9YZfFM88mqJSerLF/uArhM+KJGDpk3EKd4sBEnVAhFb/qDNFN4jzPndex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ghBwuhnY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ghBwuhnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723179;
	bh=zgjalkyaZN7cUZOI3jfW3Rc23Mnum25IcbZ9KTZSQyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ghBwuhnYV2BV+W5KN2oNqs0+sf89g5H+k5joxGtfghWCHc5rCmTOLHYRkqkF333Dl
	 9zxlhbVFKx5hrlnTLU9e/owG4OGIQgyGjtH+7sdh96z5KqaDm6mVhvMaQnZagUE1X9
	 hfdEdCVwv6EVhduJ1SUBaxdRtJo64besXgQ1pQcY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:34 +0200
Subject: [PATCH RFC 10/11] rust: device: remove logging methods
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-10-832e4039b71f@weissschuh.net>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
In-Reply-To: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
To: Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Lyude Paul <lyude@redhat.com>, Yury Norov <yury.norov@gmail.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, driver-core@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=10459;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zgjalkyaZN7cUZOI3jfW3Rc23Mnum25IcbZ9KTZSQyU=;
 b=tSLe8wnaOCcWO8pVL9yfUYFDoyP1xup7kby6lCnupbJatdPn37gvbyFHSjgKs+DsrS1MVaZYw
 nivK/i05BxWAhCHbSTcjuv9R0mo5GHHqv4vLaIHWa8ZX426WolAh/ya
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To support dynamic debug, the logging needs to happen through a macro
call. Only a macro provides the possibility to statically allocate the
descriptor used by the dynamic debug core.

For consistency also remove the other logging methods.
They have no external users anyways.

All functions are thin wrappers around Device::printk() anyways.
Only Device::pr_dbg() contains additional logic, move that to
!dev_dbg().

As a side-effect this now evaluates cfg(debug_assertions) in the context
of the caller and not device.rs. Which matches the C macros better.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 rust/kernel/device.rs | 164 +++++++++++++++++++++-----------------------------
 1 file changed, 70 insertions(+), 94 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849..2d49063f4f7c 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -298,88 +298,6 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::device) -> &'a Self {
         unsafe { &*ptr.cast() }
     }
 
-    /// Prints an emergency-level message (level 0) prefixed with device information.
-    ///
-    /// More details are available from [`dev_emerg`].
-    ///
-    /// [`dev_emerg`]: crate::dev_emerg
-    pub fn pr_emerg(&self, args: fmt::Arguments<'_>) {
-        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
-        unsafe { self.printk(bindings::KERN_EMERG, args) };
-    }
-
-    /// Prints an alert-level message (level 1) prefixed with device information.
-    ///
-    /// More details are available from [`dev_alert`].
-    ///
-    /// [`dev_alert`]: crate::dev_alert
-    pub fn pr_alert(&self, args: fmt::Arguments<'_>) {
-        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
-        unsafe { self.printk(bindings::KERN_ALERT, args) };
-    }
-
-    /// Prints a critical-level message (level 2) prefixed with device information.
-    ///
-    /// More details are available from [`dev_crit`].
-    ///
-    /// [`dev_crit`]: crate::dev_crit
-    pub fn pr_crit(&self, args: fmt::Arguments<'_>) {
-        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
-        unsafe { self.printk(bindings::KERN_CRIT, args) };
-    }
-
-    /// Prints an error-level message (level 3) prefixed with device information.
-    ///
-    /// More details are available from [`dev_err`].
-    ///
-    /// [`dev_err`]: crate::dev_err
-    pub fn pr_err(&self, args: fmt::Arguments<'_>) {
-        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
-        unsafe { self.printk(bindings::KERN_ERR, args) };
-    }
-
-    /// Prints a warning-level message (level 4) prefixed with device information.
-    ///
-    /// More details are available from [`dev_warn`].
-    ///
-    /// [`dev_warn`]: crate::dev_warn
-    pub fn pr_warn(&self, args: fmt::Arguments<'_>) {
-        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
-        unsafe { self.printk(bindings::KERN_WARNING, args) };
-    }
-
-    /// Prints a notice-level message (level 5) prefixed with device information.
-    ///
-    /// More details are available from [`dev_notice`].
-    ///
-    /// [`dev_notice`]: crate::dev_notice
-    pub fn pr_notice(&self, args: fmt::Arguments<'_>) {
-        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
-        unsafe { self.printk(bindings::KERN_NOTICE, args) };
-    }
-
-    /// Prints an info-level message (level 6) prefixed with device information.
-    ///
-    /// More details are available from [`dev_info`].
-    ///
-    /// [`dev_info`]: crate::dev_info
-    pub fn pr_info(&self, args: fmt::Arguments<'_>) {
-        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
-        unsafe { self.printk(bindings::KERN_INFO, args) };
-    }
-
-    /// Prints a debug-level message (level 7) prefixed with device information.
-    ///
-    /// More details are available from [`dev_dbg`].
-    ///
-    /// [`dev_dbg`]: crate::dev_dbg
-    pub fn pr_dbg(&self, args: fmt::Arguments<'_>) {
-        if cfg!(debug_assertions) {
-            // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
-            unsafe { self.printk(bindings::KERN_DEBUG, args) };
-        }
-    }
-
     /// Prints the provided message to the console.
     ///
     /// # Safety
@@ -387,7 +305,7 @@ pub fn pr_dbg(&self, args: fmt::Arguments<'_>) {
     /// Callers must ensure that `klevel` is null-terminated; in particular, one of the
     /// `KERN_*`constants, for example, `KERN_CRIT`, `KERN_ALERT`, etc.
     #[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
-    unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
+    pub unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
         // SAFETY: `klevel` is null-terminated and one of the kernel constants. `self.as_raw`
         // is valid because `self` is valid. The "%pA" format string expects a pointer to
         // `fmt::Arguments`, which is what we're passing as the last argument.
@@ -738,9 +656,9 @@ macro_rules! impl_device_context_into_aref {
 #[doc(hidden)]
 #[macro_export]
 macro_rules! dev_printk {
-    ($method:ident, $dev:expr, $($f:tt)*) => {
-        $crate::device::Device::$method($dev.as_ref(), $crate::prelude::fmt!($($f)*))
-    }
+    ($klevel:expr, $dev:expr, $args:expr) => {
+        $crate::device::Device::printk($dev.as_ref(), $klevel, $args)
+    };
 }
 
 /// Prints an emergency-level message (level 0) prefixed with device information.
@@ -766,7 +684,14 @@ macro_rules! dev_printk {
 /// ```
 #[macro_export]
 macro_rules! dev_emerg {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_emerg, $($f)*) }
+    ($dev:expr, $($f:tt)*) => {
+        match (&$dev, $crate::prelude::fmt!($($f)*)) {
+            (dev, args) => {
+                // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+                unsafe { $crate::dev_printk!($crate::bindings::KERN_EMERG, dev, args) }
+            }
+        }
+    }
 }
 
 /// Prints an alert-level message (level 1) prefixed with device information.
@@ -792,7 +717,14 @@ macro_rules! dev_emerg {
 /// ```
 #[macro_export]
 macro_rules! dev_alert {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_alert, $($f)*) }
+    ($dev:expr, $($f:tt)*) => {
+        match (&$dev, $crate::prelude::fmt!($($f)*)) {
+            (dev, args) => {
+                // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+                unsafe { $crate::dev_printk!($crate::bindings::KERN_ALERT, dev, args) }
+            }
+        }
+    }
 }
 
 /// Prints a critical-level message (level 2) prefixed with device information.
@@ -818,7 +750,14 @@ macro_rules! dev_alert {
 /// ```
 #[macro_export]
 macro_rules! dev_crit {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_crit, $($f)*) }
+    ($dev:expr, $($f:tt)*) => {
+        match (&$dev, $crate::prelude::fmt!($($f)*)) {
+            (dev, args) => {
+                // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+                unsafe { $crate::dev_printk!($crate::bindings::KERN_CRIT, dev, args) }
+            }
+        }
+    }
 }
 
 /// Prints an error-level message (level 3) prefixed with device information.
@@ -844,7 +783,14 @@ macro_rules! dev_crit {
 /// ```
 #[macro_export]
 macro_rules! dev_err {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_err, $($f)*) }
+    ($dev:expr, $($f:tt)*) => {
+        match (&$dev, $crate::prelude::fmt!($($f)*)) {
+            (dev, args) => {
+                // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+                unsafe { $crate::dev_printk!($crate::bindings::KERN_ERR, dev, args) }
+            }
+        }
+    }
 }
 
 /// Prints a warning-level message (level 4) prefixed with device information.
@@ -870,7 +816,14 @@ macro_rules! dev_err {
 /// ```
 #[macro_export]
 macro_rules! dev_warn {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_warn, $($f)*) }
+    ($dev:expr, $($f:tt)*) => {
+        match (&$dev, $crate::prelude::fmt!($($f)*)) {
+            (dev, args) => {
+                // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+                unsafe { $crate::dev_printk!($crate::bindings::KERN_WARNING, dev, args) }
+            }
+        }
+    }
 }
 
 /// Prints a notice-level message (level 5) prefixed with device information.
@@ -896,7 +849,14 @@ macro_rules! dev_warn {
 /// ```
 #[macro_export]
 macro_rules! dev_notice {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_notice, $($f)*) }
+    ($dev:expr, $($f:tt)*) => {
+        match (&$dev, $crate::prelude::fmt!($($f)*)) {
+            (dev, args) => {
+                // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+                unsafe { $crate::dev_printk!($crate::bindings::KERN_NOTICE, dev, args) }
+            }
+        }
+    }
 }
 
 /// Prints an info-level message (level 6) prefixed with device information.
@@ -922,7 +882,14 @@ macro_rules! dev_notice {
 /// ```
 #[macro_export]
 macro_rules! dev_info {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_info, $($f)*) }
+    ($dev:expr, $($f:tt)*) => {
+        match (&$dev, $crate::prelude::fmt!($($f)*)) {
+            (dev, args) => {
+                // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+                unsafe { $crate::dev_printk!($crate::bindings::KERN_INFO, dev, args) }
+            }
+        }
+    }
 }
 
 /// Prints a debug-level message (level 7) prefixed with device information.
@@ -948,5 +915,14 @@ macro_rules! dev_info {
 /// ```
 #[macro_export]
 macro_rules! dev_dbg {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_dbg, $($f)*) }
+    ($dev:expr, $($f:tt)*) => {
+        match (&$dev, $crate::prelude::fmt!($($f)*)) {
+            (dev, args) => {
+                if cfg!(debug_assertions) {
+                    // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+                    unsafe { $crate::dev_printk!($crate::bindings::KERN_DEBUG, dev, args) }
+                }
+            }
+        }
+    }
 }

-- 
2.56.0

