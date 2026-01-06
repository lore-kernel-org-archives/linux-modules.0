Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF7A280CE5
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716005; cv=none; b=XknEYmSyqYp3RXywv30PxjlEk8hag/MrutgHQlDgJ1JdkCpDON0ldCFgH78Pjucy1ZHICbZwljF4gd3J9sHwwpOuxMuZLTgQmTKpEHk2a+XYhp6UkSKDKQugQx82xOaudPNcY2PCu9Ox1LyUkS+LYXwAbnlLeH1zdq85ViqdNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716005; c=relaxed/simple;
	bh=UTNOeFwTGihFmlxHJgeXPwIlyRNHZuCVFbumdp1zOoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+nqd0qAlR6r9tXrzJw5oo3n2QfiEUnD2mBlDON36Ak8yvULFC+YtylQpyTQfUR3WY++39hQ83H+HOkwgvsmcBgHkENBA6jBve+7i/rNVExV9ParnJJUHSzBoO6Rd0K451lvf7wkA8YAz2OaMampGfhexHVC7OasVHWKsigLBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sps4K1JO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sps4K1JO"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59431f57bf6so1163523e87.3
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767715999; x=1768320799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cO44XyCgtGl8WrKQeDHWNuLpTRXz0AQwF9LfwT0N9ro=;
        b=Sps4K1JOXzurYrdGsz9xKP7qdhBTfLSFRUQfmBKgdAg/LV+IWHa34XRXKLKZaGAJWL
         BM6DDhAgOkwLiLV2yx90OFTeV/p4vHfITfwecDySaBT/m+e1TxlKrqTTJqSweR0tSu8/
         vrmwh22/PvdyaHN9wwR/LKNID4CZpvrVT/t7eJ6sea9Y+wgYU2bJBTYQs7g5nbkPcNeR
         Cpf+ziz+t1r59wbYLpnqDO62hyqWhkqgFdE41yDiAOozzVUGT8GCvbgLltAZ7okyN81A
         ILdUofKKVgTGA2q5iMmXgVVJmxKts9SNEPEDkg4d7t7/ZuDdoCS7HgCsQaIsMbIu04Dg
         XKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715999; x=1768320799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cO44XyCgtGl8WrKQeDHWNuLpTRXz0AQwF9LfwT0N9ro=;
        b=wlhLJB+jlB2L/9f2iC8a00X+3ugiPCJF5mvHQnPh8cxHPJCkcth7a0/RrED/ti47ZH
         qt20sok6ns62rQJi6Irf5V9/PobPu4C3t+6EV0JsO9pjTlfzWcV0ap2eakmHutSq1I7Y
         vR3yD5aDdTj+APxQQDN2cj/j5xYjHooIntXujbrDWX1SpH/4lLpXdpdSQcwxa32GQIJn
         XeyziuDOk3Hl4lmpRD7zL72r7Gfv7FeqnokScBYkC6okKYVY+RMLfcX9ZncyAYpzqLXc
         V74+bf+cSR6gImgbITiOO74GFGgE8U8xCvTb7BhZ+JHi3mY8aGHUqyqEvk8yBc0yzeCG
         iNWw==
X-Forwarded-Encrypted: i=1; AJvYcCWqlWRdzP0H1QBUxI6UetRr+vcbPALBO5qxlKQHzaWYpq8hjmftbGYTpM0MSameuN0F8yl9LLwFTtL4vSAD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XuovXFwAYlQuK9UBrD8Vb3oA3S8mjJIcigb38d3Mme05siLN
	gK06ntRvafZSbD7vWVIXbGd9DZdGeDfR+/kEKnDV5coW/Nz/IEcHQgq/
X-Gm-Gg: AY/fxX59JK19omI9JhDOPnI29Cm4Bt8QPz+GWfFe7pKuwqmipPKGqRjvNjrphxbChbb
	rhmdGrMPfPUugMpPQ81fdzr8n0npeZTl8Uha5afRLgAvumR1osSDKyd2HbQP2Qf6XrSWluPftRu
	lBhcMp7l8nKVRrursw346MtI4myKwqO210aENpKrOzYgIr7yOQYGv9r0Nt2snFKn+QGavWwA1c0
	h/7VCpitmYFjRo4bJc+eHrfTEFL6mSB20qc+zK+vY+5OgdVq92RdAQcYYCEnOh3ltqg4+5wgALN
	rqQ0jKEJSE4o1e2YKAPNsrFVqlnCJrj/edkbSj1QKWSM817jh4Djg81dB8KTGzPNngoF+UdB0S/
	tVY1wC1a3HTKchFtEp2H9LRDoZWbIgpBHvlD7lyb4dGfRr2TNs7k8qB5EdqIn6O5wajHXUVtl85
	sRL9TnPPnne8CWhcY4oknHFTXjwZK63sb8bH7nbKieg6FuLHGcINT89cE8ksdADZ5HNnKOIenPb
	3+RmwoWEAJ0Tg54
X-Google-Smtp-Source: AGHT+IHZLlib1FdNp6Mz3hTD00GnfYsdeklIwQwb155sldQfNtXmxDGwSdPNh/AFDq9/FqP+wutAPw==
X-Received: by 2002:a05:6512:4016:b0:59a:108a:3215 with SMTP id 2adb3069b0e04-59b65292ccdmr1193890e87.23.1767715998955;
        Tue, 06 Jan 2026 08:13:18 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:18 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:44 +0200
Subject: [PATCH RFC v2 06/11] rust: driver: make
 RegistrationOps::register() to use new ThisModule
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-this_module_fix-v2-6-842ac026f00b@gmail.com>
References: <20260106-this_module_fix-v2-0-842ac026f00b@gmail.com>
In-Reply-To: <20260106-this_module_fix-v2-0-842ac026f00b@gmail.com>
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
 Kari Argillander <kari.argillander@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=12781;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=UTNOeFwTGihFmlxHJgeXPwIlyRNHZuCVFbumdp1zOoM=;
 b=DGUQmoqLCaQuejFYSYafK1smRUP3ShGq814VX89TAFuGO/2cknLNDFFelQnPhYq88scSSs2rx
 oNXoB+ngwz9Cdpu5utUuDtc8cd23TTWpFyJxHKbLJA/LfIe4C221/rk
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

New version of ThisModule is trait which can be passed in const context.
To have unified way to pass THIS_MODULE to abstactions have const
parameter which can be used to get owner and name.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/auxiliary.rs              | 16 ++++++++--------
 rust/kernel/driver.rs                 | 29 +++++++++++++----------------
 rust/kernel/i2c.rs                    | 11 ++++-------
 rust/kernel/pci.rs                    | 15 +++++----------
 rust/kernel/platform.rs               | 12 ++++--------
 rust/kernel/usb.rs                    | 13 ++++---------
 samples/rust/rust_driver_auxiliary.rs |  6 +++---
 7 files changed, 41 insertions(+), 61 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 56f3c180e8f6..102b0349af16 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -11,8 +11,8 @@
     driver,
     error::{from_result, to_result, Result},
     prelude::*,
+    this_module::ThisModule,
     types::Opaque,
-    ThisModule,
 };
 use core::{
     marker::PhantomData,
@@ -28,14 +28,10 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::auxiliary_driver;
 
-    unsafe fn register(
-        adrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<TM: ThisModule>(adrv: &Opaque<Self::RegType>) -> Result {
         // SAFETY: It's safe to set the fields of `struct auxiliary_driver` on initialization.
         unsafe {
-            (*adrv.get()).name = name.as_char_ptr();
+            (*adrv.get()).name = TM::NAME.as_char_ptr();
             (*adrv.get()).probe = Some(Self::probe_callback);
             (*adrv.get()).remove = Some(Self::remove_callback);
             (*adrv.get()).id_table = T::ID_TABLE.as_ptr();
@@ -43,7 +39,11 @@ unsafe fn register(
 
         // SAFETY: `adrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
-            bindings::__auxiliary_driver_register(adrv.get(), module.0, name.as_char_ptr())
+            bindings::__auxiliary_driver_register(
+                adrv.get(),
+                TM::OWNER.as_ptr(),
+                TM::NAME.as_char_ptr(),
+            )
         })
     }
 
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 649d06468f41..dc7522c4ebda 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -94,10 +94,14 @@
 //! [`device_id`]: kernel::device_id
 //! [`module_driver`]: kernel::module_driver
 
-use crate::error::{Error, Result};
-use crate::{acpi, device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
-use core::pin::Pin;
-use pin_init::{pin_data, pinned_drop, PinInit};
+use crate::{
+    acpi,
+    device,
+    of,
+    prelude::*,
+    this_module::ThisModule,
+    types::Opaque, //
+};
 
 /// The [`RegistrationOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform,
 /// Amba, etc.) to provide the corresponding subsystem specific implementation to register /
@@ -122,11 +126,7 @@ pub unsafe trait RegistrationOps {
     ///
     /// On success, `reg` must remain pinned and valid until the matching call to
     /// [`RegistrationOps::unregister`].
-    unsafe fn register(
-        reg: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result;
+    unsafe fn register<TM: ThisModule>(reg: &Opaque<Self::RegType>) -> Result;
 
     /// Unregisters a driver previously registered with [`RegistrationOps::register`].
     ///
@@ -159,7 +159,7 @@ unsafe impl<T: RegistrationOps> Send for Registration<T> {}
 
 impl<T: RegistrationOps> Registration<T> {
     /// Creates a new instance of the registration object.
-    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    pub fn new<TM: ThisModule>() -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
             reg <- Opaque::try_ffi_init(|ptr: *mut T::RegType| {
                 // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
@@ -170,7 +170,7 @@ pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Sel
                 let drv = unsafe { &*(ptr as *const Opaque<T::RegType>) };
 
                 // SAFETY: `drv` is guaranteed to be pinned until `T::unregister`.
-                unsafe { T::register(drv, name, module) }
+                unsafe { T::register::<TM>(drv) }
             }),
         })
     }
@@ -202,13 +202,10 @@ struct DriverModule {
 
         impl $crate::InPlaceModule for DriverModule {
             fn init(
-                module: &'static $crate::ThisModule
+                _module: &'static $crate::ThisModule
             ) -> impl ::pin_init::PinInit<Self, $crate::error::Error> {
                 $crate::try_pin_init!(Self {
-                    _driver <- $crate::driver::Registration::new(
-                        <Self as $crate::ModuleMetadata>::NAME,
-                        module,
-                    ),
+                    _driver <- $crate::driver::Registration::new::<crate::THIS_MODULE>(),
                 })
             }
         }
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 491e6cc25cf4..b23a26a445cd 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -16,6 +16,7 @@
     error::*,
     of,
     prelude::*,
+    this_module::ThisModule,
     types::{
         AlwaysRefCounted,
         Opaque, //
@@ -97,11 +98,7 @@ macro_rules! i2c_device_table {
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::i2c_driver;
 
-    unsafe fn register(
-        idrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<TM: ThisModule>(idrv: &Opaque<Self::RegType>) -> Result {
         build_assert!(
             T::ACPI_ID_TABLE.is_some() || T::OF_ID_TABLE.is_some() || T::I2C_ID_TABLE.is_some(),
             "At least one of ACPI/OF/Legacy tables must be present when registering an i2c driver"
@@ -124,7 +121,7 @@ unsafe fn register(
 
         // SAFETY: It's safe to set the fields of `struct i2c_client` on initialization.
         unsafe {
-            (*idrv.get()).driver.name = name.as_char_ptr();
+            (*idrv.get()).driver.name = TM::NAME.as_char_ptr();
             (*idrv.get()).probe = Some(Self::probe_callback);
             (*idrv.get()).remove = Some(Self::remove_callback);
             (*idrv.get()).shutdown = Some(Self::shutdown_callback);
@@ -134,7 +131,7 @@ unsafe fn register(
         }
 
         // SAFETY: `idrv` is guaranteed to be a valid `RegType`.
-        to_result(unsafe { bindings::i2c_register_driver(module.0, idrv.get()) })
+        to_result(unsafe { bindings::i2c_register_driver(TM::OWNER.as_ptr(), idrv.get()) })
     }
 
     unsafe fn unregister(idrv: &Opaque<Self::RegType>) {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 82e128431f08..88a5416fb44b 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -18,9 +18,8 @@
         to_result, //
     },
     prelude::*,
-    str::CStr,
-    types::Opaque,
-    ThisModule, //
+    this_module::ThisModule,
+    types::Opaque, //
 };
 use core::{
     marker::PhantomData,
@@ -55,14 +54,10 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::pci_driver;
 
-    unsafe fn register(
-        pdrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<TM: ThisModule>(pdrv: &Opaque<Self::RegType>) -> Result {
         // SAFETY: It's safe to set the fields of `struct pci_driver` on initialization.
         unsafe {
-            (*pdrv.get()).name = name.as_char_ptr();
+            (*pdrv.get()).name = TM::NAME.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
@@ -70,7 +65,7 @@ unsafe fn register(
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
-            bindings::__pci_register_driver(pdrv.get(), module.0, name.as_char_ptr())
+            bindings::__pci_register_driver(pdrv.get(), TM::OWNER.as_ptr(), TM::NAME.as_char_ptr())
         })
     }
 
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index bddb593cee7b..a4678af3b891 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -13,8 +13,8 @@
     irq::{self, IrqRequest},
     of,
     prelude::*,
+    this_module::ThisModule,
     types::Opaque,
-    ThisModule,
 };
 
 use core::{
@@ -31,11 +31,7 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::platform_driver;
 
-    unsafe fn register(
-        pdrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<TM: ThisModule>(pdrv: &Opaque<Self::RegType>) -> Result {
         let of_table = match T::OF_ID_TABLE {
             Some(table) => table.as_ptr(),
             None => core::ptr::null(),
@@ -48,7 +44,7 @@ unsafe fn register(
 
         // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
         unsafe {
-            (*pdrv.get()).driver.name = name.as_char_ptr();
+            (*pdrv.get()).driver.name = TM::NAME.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
@@ -56,7 +52,7 @@ unsafe fn register(
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
-        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) })
+        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), TM::OWNER.as_ptr()) })
     }
 
     unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index d10b65e9fb6a..e7e07360f953 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -11,9 +11,8 @@
     driver,
     error::{from_result, to_result, Result},
     prelude::*,
-    str::CStr,
+    this_module::ThisModule,
     types::{AlwaysRefCounted, Opaque},
-    ThisModule,
 };
 use core::{
     marker::PhantomData,
@@ -32,14 +31,10 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::usb_driver;
 
-    unsafe fn register(
-        udrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<TM: ThisModule>(udrv: &Opaque<Self::RegType>) -> Result {
         // SAFETY: It's safe to set the fields of `struct usb_driver` on initialization.
         unsafe {
-            (*udrv.get()).name = name.as_char_ptr();
+            (*udrv.get()).name = TM::NAME.as_char_ptr();
             (*udrv.get()).probe = Some(Self::probe_callback);
             (*udrv.get()).disconnect = Some(Self::disconnect_callback);
             (*udrv.get()).id_table = T::ID_TABLE.as_ptr();
@@ -47,7 +42,7 @@ unsafe fn register(
 
         // SAFETY: `udrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
-            bindings::usb_register_driver(udrv.get(), module.0, name.as_char_ptr())
+            bindings::usb_register_driver(udrv.get(), TM::OWNER.as_ptr(), TM::NAME.as_char_ptr())
         })
     }
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 1e4fb23cfcb0..28a25e540298 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -111,10 +111,10 @@ struct SampleModule {
 }
 
 impl InPlaceModule for SampleModule {
-    fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
+    fn init(_module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
-            _pci_driver <- driver::Registration::new(MODULE_NAME, module),
-            _aux_driver <- driver::Registration::new(MODULE_NAME, module),
+            _pci_driver <- driver::Registration::new::<THIS_MODULE>(),
+            _aux_driver <- driver::Registration::new::<THIS_MODULE>(),
         })
     }
 }

-- 
2.43.0

