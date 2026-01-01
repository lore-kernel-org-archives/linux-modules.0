Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD542512C8
	for <linux-modules@vger.kernel.org>; Thu,  1 Jan 2026 05:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767244920; cv=none; b=MCLfnqjeObL8wFt3yaLitDX4cVilg1trRThq3Hvwi5W/8YcpMc1Xsbkxa+xRFmear53/0w9nywsdaXvy6AyMsawFwEWylOV18F8tDc9QTOxZ5cH25zNs/Ti1kZpOU5AEDaJXgCh26U6r6KH3YUMEiCv3f/wk4FxjB8ak8E6FeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767244920; c=relaxed/simple;
	bh=KJQ4jpYSGm/3nhZ2nBbnbAiByofjpfGBkERW9T5CzMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oynhBpqpbeJPQNkK1XaZTEHfJGJuzEpvhM9V7A4F5sbr2UDvjtbQtRjnfW92hty46RlzQ4wnhPl3/nYdFYFmLq7qb/uHNS1nhMszuYT8i3EOig9m5fC1qbTCPVf+uaiaMIyTXkpJcwrqZafhOM9KtpD4CNV/t5CSbJ2BeGqRJO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8SfiUOG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8SfiUOG"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b983fbd45so85711401fa.3
        for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 21:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767244915; x=1767849715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCtaSXGPRcSbvYyqIPMnOeQLbklJUshA1S2PP0SMOWU=;
        b=W8SfiUOGab+mVjvrfzk/33yX079OgglDKXsquQVI4bjSwr+NAIphOQ0dPWEtcKwQKV
         r9dTZCKw6pGWEFFXMx94XhpTfWhzQxpRm6XioKypGjKEwBN8iLy5T47VmVhUnJhJkQtO
         NcKB4R2tZ8xKqChT2UM4L73ojVXqVowPSooi3o38YYfX6iLdZJmouPQtzNyDJKK+z7/U
         0iEkcoq3an+DuQJsqdR35jpX/vF+D3kf3lzaBFqm3J1z0hmF/3tjv0fu75O/ZnHIeB86
         /nLMvgzM1NjXKUdz3deG9NXgRCVNitauHN0OLSDh5z/r9fP98m+A7+SKpbOnd4gNsOW0
         mAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767244915; x=1767849715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCtaSXGPRcSbvYyqIPMnOeQLbklJUshA1S2PP0SMOWU=;
        b=eDbOlcpk7GTgZJVH8SmME8QajCVg+uddg6etJY/oQ0gbbC5ifSS9OJw5QoUaiZ6OSa
         v0noB9nKOv2BK8RwX4We7lkqb7y8tWVlEuRxvqD4JTRVX5MJ6xQb51hiL8KPOOiI0EY+
         ds3NJu3OJq9Q2wd2nuuzcM2Br/dXRY3/Z+3xXGSfKd+Bt2wM6YOMn9tDZiU0abRAzEGv
         nI5rsUcYZ4vX9qMUWDLAVIlhIs/GL7qruGL1cpmLOpTxfQnYUYsCDnz3tiRVdoYTWsn/
         AwRJUhhCZmEsAUqzuqdj67DDhbvAT4kKId2T1V95PtYPgdpLsPg0lSFxz4dCx25J79YC
         fPmg==
X-Forwarded-Encrypted: i=1; AJvYcCW5N2RMFRDzddRtwBVnU+2KFePQVWOH8G/1PEM6P5QId87nhUginXeYNrMs34OEQ+zbwJCA+LnL9u4kua5t@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+gX6V2dFx3NPmlKumAjE/lB8n4K+YCSYWzfr88IWTPAM/hi8
	BIDyQAblAekO7Wb8XnJJVut/smysxu4E3HyEmUej90MQ02OO3MErRl9J
X-Gm-Gg: AY/fxX6UfiPVN6YTb32wHaXyaq+nMO4vKRkNnJDvwOe0+JJIlG2twbdTSX7eJabh7cT
	55rYQ7M+P9UCKCg2qh5rCxyfXRLgp9vOtDpu/dGVbl2hFIYkR0oiiWwKdOy1EKpsb+uqj/PBWSp
	/lkAuSOLzRPP7k/6ic91lm3B0Cj3LFqPmzgKPdcf2Y05NFyWyaX9vgR5wbp99QuxB+jYn+drfvU
	1ESA5x3PeWzN28huIVDUgCMhXJMarGFDRGKvhuyaDvhulY5LsaDOwv9BEWQDu9zLZ3n97rE90pC
	wUffbyaGMTaSE/GYCRpGYLOe4tY78cva9ExQ6jm9P5OIUHEWnihPGcv9NTB43Qg4bG3Pf2OKEbh
	CzkU8dTRriOqe/L+EpdphuDDNTi+lmXXZdy60Nvp3tUuzTxqBsp4EdopqzlMa0ojRHxGiSFqveb
	eCfMrCUV8tdB8qM4O+/O8wBR9khfXkAYNwbOuodU/8CLhPQZsU+fdQBQzgm36gtXpRrBZnlTM+B
	yWlPw==
X-Google-Smtp-Source: AGHT+IE44rsnY6ipPrk3/J7X1yUoLY5WMocdogdmnIRKh23tOr7xkmlRQ6aQFRsTEn6UW4FJGOVNiA==
X-Received: by 2002:a2e:a993:0:b0:382:b559:8336 with SMTP id 38308e7fff4ca-382b55983b4mr984331fa.22.1767244915067;
        Wed, 31 Dec 2025 21:21:55 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (84-253-216-54.bb.dnainternet.fi. [84.253.216.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382861ef4ccsm37064921fa.23.2025.12.31.21.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 21:21:53 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Thu, 01 Jan 2026 07:20:50 +0200
Subject: [PATCH RFC 6/6] rust: WIP: Replace ModuleMetadata with THIS_MODULE
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-this_module_fix-v1-6-46ae3e5605a0@gmail.com>
References: <20260101-this_module_fix-v1-0-46ae3e5605a0@gmail.com>
In-Reply-To: <20260101-this_module_fix-v1-0-46ae3e5605a0@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jens Axboe <axboe@kernel.dk>, Kari Argillander <kari.argillander@gmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767244881; l=13418;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=KJQ4jpYSGm/3nhZ2nBbnbAiByofjpfGBkERW9T5CzMA=;
 b=gFUZ/58AraibpqH01HqbZhQb+XNzgNCXh3sNTjmMWxdx2lrddwUWZPbsMGPtHuo9cNjvK7Gnk
 08Orxt2elZ7CXFWUsZAPrZSWyFOPO4sQv3P7Qixgg1aPs6qOQRb92/+
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

ModuleMetadata seems redudant after we have prober THIS_MODULE.
---
 drivers/gpu/nova-core/nova_core.rs    |  2 +-
 rust/kernel/auxiliary.rs              | 10 +++++++---
 rust/kernel/driver.rs                 | 10 ++++------
 rust/kernel/firmware.rs               |  2 +-
 rust/kernel/i2c.rs                    |  4 ++--
 rust/kernel/lib.rs                    |  8 ++------
 rust/kernel/pci.rs                    |  6 +++---
 rust/kernel/platform.rs               |  4 ++--
 rust/kernel/usb.rs                    |  6 +++---
 rust/macros/module.rs                 | 13 +++++++------
 samples/rust/rust_driver_auxiliary.rs |  6 +++---
 11 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index b98a1c03f13d..fbfbcc9446c0 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -19,7 +19,7 @@
 mod util;
 mod vbios;
 
-pub(crate) const MODULE_NAME: &kernel::str::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
+pub(crate) const MODULE_NAME: &kernel::str::CStr = THIS_MODULE::name();
 
 kernel::module_pci_driver! {
     type: driver::NovaCore,
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 323074322505..bd064b677c05 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -27,10 +27,10 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::auxiliary_driver;
 
-    unsafe fn register<M: ThisModule>(adrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
+    unsafe fn register<M: ThisModule>(adrv: &Opaque<Self::RegType>) -> Result {
         // SAFETY: It's safe to set the fields of `struct auxiliary_driver` on initialization.
         unsafe {
-            (*adrv.get()).name = name.as_char_ptr();
+            (*adrv.get()).name = M::NAME.as_char_ptr();
             (*adrv.get()).probe = Some(Self::probe_callback);
             (*adrv.get()).remove = Some(Self::remove_callback);
             (*adrv.get()).id_table = T::ID_TABLE.as_ptr();
@@ -38,7 +38,11 @@ unsafe fn register<M: ThisModule>(adrv: &Opaque<Self::RegType>, name: &'static C
 
         // SAFETY: `adrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
-            bindings::__auxiliary_driver_register(adrv.get(), M::OWNER.as_ptr(), name.as_char_ptr())
+            bindings::__auxiliary_driver_register(
+                adrv.get(),
+                M::OWNER.as_ptr(),
+                M::NAME.as_char_ptr(),
+            )
         })
     }
 
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 7c4ad24bb48a..5bb029075a57 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -118,7 +118,7 @@ pub unsafe trait RegistrationOps {
     ///
     /// On success, `reg` must remain pinned and valid until the matching call to
     /// [`RegistrationOps::unregister`].
-    unsafe fn register<M: ThisModule>(reg: &Opaque<Self::RegType>, name: &'static CStr) -> Result;
+    unsafe fn register<M: ThisModule>(reg: &Opaque<Self::RegType>) -> Result;
 
     /// Unregisters a driver previously registered with [`RegistrationOps::register`].
     ///
@@ -151,7 +151,7 @@ unsafe impl<T: RegistrationOps> Send for Registration<T> {}
 
 impl<T: RegistrationOps> Registration<T> {
     /// Creates a new instance of the registration object.
-    pub fn new<M: ThisModule>(name: &'static CStr) -> impl PinInit<Self, Error> {
+    pub fn new<M: ThisModule>() -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
             reg <- Opaque::try_ffi_init(|ptr: *mut T::RegType| {
                 // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
@@ -162,7 +162,7 @@ pub fn new<M: ThisModule>(name: &'static CStr) -> impl PinInit<Self, Error> {
                 let drv = unsafe { &*(ptr as *const Opaque<T::RegType>) };
 
                 // SAFETY: `drv` is guaranteed to be pinned until `T::unregister`.
-                unsafe { T::register::<M>(drv, name) }
+                unsafe { T::register::<M>(drv) }
             }),
         })
     }
@@ -195,9 +195,7 @@ struct DriverModule {
         impl $crate::InPlaceModule for DriverModule {
             fn init<M: ::kernel::ThisModule>() -> impl ::pin_init::PinInit<Self, $crate::error::Error> {
                 $crate::try_pin_init!(Self {
-                    _driver <- $crate::driver::Registration::new::<M>(
-                        <Self as $crate::ModuleMetadata>::NAME,
-                    ),
+                    _driver <- $crate::driver::Registration::new::<M>(),
                 })
             }
         }
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 71168d8004e2..254b5c6b64af 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -206,7 +206,7 @@ macro_rules! module_firmware {
             const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
                 c""
             } else {
-                <LocalModule as $crate::ModuleMetadata>::NAME
+                THIS_MODULE::name()
             };
 
             #[link_section = ".modinfo"]
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index bc154506b16f..31db4d45bab1 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -97,7 +97,7 @@ macro_rules! i2c_device_table {
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::i2c_driver;
 
-    unsafe fn register<M: ThisModule>(idrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
+    unsafe fn register<M: ThisModule>(idrv: &Opaque<Self::RegType>) -> Result {
         build_assert!(
             T::ACPI_ID_TABLE.is_some() || T::OF_ID_TABLE.is_some() || T::I2C_ID_TABLE.is_some(),
             "At least one of ACPI/OF/Legacy tables must be present when registering an i2c driver"
@@ -120,7 +120,7 @@ unsafe fn register<M: ThisModule>(idrv: &Opaque<Self::RegType>, name: &'static C
 
         // SAFETY: It's safe to set the fields of `struct i2c_client` on initialization.
         unsafe {
-            (*idrv.get()).driver.name = name.as_char_ptr();
+            (*idrv.get()).driver.name = M::NAME.as_char_ptr();
             (*idrv.get()).probe = Some(Self::probe_callback);
             (*idrv.get()).remove = Some(Self::remove_callback);
             (*idrv.get()).shutdown = Some(Self::shutdown_callback);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6d4563662a02..3bae80a949d2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -199,12 +199,6 @@ fn init<M: ThisModule>() -> impl pin_init::PinInit<Self, error::Error> {
     }
 }
 
-/// Metadata attached to a [`Module`] or [`InPlaceModule`].
-pub trait ModuleMetadata {
-    /// The name of the module as specified in the `module!` macro.
-    const NAME: &'static crate::str::CStr;
-}
-
 pub mod this_module {
     //! TODO
     //!
@@ -224,6 +218,8 @@ pub mod this_module {
     pub trait ThisModule {
         /// TODO Doc
         const OWNER: ModuleWrapper;
+        /// TODO Doc
+        const NAME: &'static kernel::str::CStr;
     }
 
     /// See [`this_module`]
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 792560ca8020..b043d7a388d0 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -54,10 +54,10 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::pci_driver;
 
-    unsafe fn register<M: ThisModule>(pdrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
+    unsafe fn register<M: ThisModule>(pdrv: &Opaque<Self::RegType>) -> Result {
         // SAFETY: It's safe to set the fields of `struct pci_driver` on initialization.
         unsafe {
-            (*pdrv.get()).name = name.as_char_ptr();
+            (*pdrv.get()).name = M::NAME.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
@@ -65,7 +65,7 @@ unsafe fn register<M: ThisModule>(pdrv: &Opaque<Self::RegType>, name: &'static C
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
-            bindings::__pci_register_driver(pdrv.get(), M::OWNER.as_ptr(), name.as_char_ptr())
+            bindings::__pci_register_driver(pdrv.get(), M::OWNER.as_ptr(), M::NAME.as_char_ptr())
         })
     }
 
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 67d46231600e..27f196a140e5 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -30,7 +30,7 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::platform_driver;
 
-    unsafe fn register<M: ThisModule>(pdrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
+    unsafe fn register<M: ThisModule>(pdrv: &Opaque<Self::RegType>) -> Result {
         let of_table = match T::OF_ID_TABLE {
             Some(table) => table.as_ptr(),
             None => core::ptr::null(),
@@ -43,7 +43,7 @@ unsafe fn register<M: ThisModule>(pdrv: &Opaque<Self::RegType>, name: &'static C
 
         // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
         unsafe {
-            (*pdrv.get()).driver.name = name.as_char_ptr();
+            (*pdrv.get()).driver.name = M::NAME.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index c6ee98d12875..43259307986f 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -31,10 +31,10 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::usb_driver;
 
-    unsafe fn register<M: ThisModule>(udrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
+    unsafe fn register<M: ThisModule>(udrv: &Opaque<Self::RegType>) -> Result {
         // SAFETY: It's safe to set the fields of `struct usb_driver` on initialization.
         unsafe {
-            (*udrv.get()).name = name.as_char_ptr();
+            (*udrv.get()).name = M::NAME.as_char_ptr();
             (*udrv.get()).probe = Some(Self::probe_callback);
             (*udrv.get()).disconnect = Some(Self::disconnect_callback);
             (*udrv.get()).id_table = T::ID_TABLE.as_ptr();
@@ -42,7 +42,7 @@ unsafe fn register<M: ThisModule>(udrv: &Opaque<Self::RegType>, name: &'static C
 
         // SAFETY: `udrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
-            bindings::usb_register_driver(udrv.get(), M::OWNER.as_ptr(), name.as_char_ptr())
+            bindings::usb_register_driver(udrv.get(), M::OWNER.as_ptr(), M::NAME.as_char_ptr())
         })
     }
 
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 6b8753d122cc..6a1ce6435e8f 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -375,6 +375,13 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             #[allow(non_camel_case_types)]
             pub struct THIS_MODULE;
 
+            impl THIS_MODULE {{
+                /// Returns the name of this module.
+                pub const fn name() -> &'static ::kernel::str::CStr {{
+                    c\"{name}\"
+                }}
+            }}
+
             impl ::kernel::prelude::ThisModule for THIS_MODULE {{
                 #[cfg(not(MODULE))] 
                 const OWNER: ::kernel::this_module::ModuleWrapper = unsafe {{
@@ -392,13 +399,7 @@ impl ::kernel::prelude::ThisModule for THIS_MODULE {{
                     
                     ::kernel::this_module::ModuleWrapper::from_ptr(__this_module.get())
                 }};
-            }}
-
-            /// The `LocalModule` type is the type of the module created by `module!`,
-            /// `module_pci_driver!`, `module_platform_driver!`, etc.
-            type LocalModule = {type_};
 
-            impl ::kernel::ModuleMetadata for {type_} {{
                 const NAME: &'static ::kernel::str::CStr = c\"{name}\";
             }}
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index e996dca19454..2f77b0873e81 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -18,7 +18,7 @@
 use core::any::TypeId;
 use pin_init::PinInit;
 
-const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
+const MODULE_NAME: &CStr = THIS_MODULE::name();
 const AUXILIARY_NAME: &CStr = c_str!("auxiliary");
 
 struct AuxiliaryDriver;
@@ -113,8 +113,8 @@ struct SampleModule {
 impl InPlaceModule for SampleModule {
     fn init<M: ThisModule>() -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
-            _pci_driver <- driver::Registration::new::<M>(MODULE_NAME),
-            _aux_driver <- driver::Registration::new::<M>(MODULE_NAME),
+            _pci_driver <- driver::Registration::new::<M>(),
+            _aux_driver <- driver::Registration::new::<M>(),
         })
     }
 }

-- 
2.43.0

