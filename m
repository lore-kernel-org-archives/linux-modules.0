Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE4231845
	for <linux-modules@vger.kernel.org>; Thu,  1 Jan 2026 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767244905; cv=none; b=KMEoicNsoJCfO9of/lhpwq3ys0C1RpRb26ECjGSTKXNYyxm7fm2TCHTsUaeT9pwM3CI2lgLuJ6cCE9fyQ2JYIBx/V3OM1wXT/Ii+4fShHju1c3l3EJXxRvsTGNw0OUEZJ+N0MW929UhkA/BvFjMIqlbfq+Bf8QEXl7r7+s5REpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767244905; c=relaxed/simple;
	bh=kV4DkY3TtJnlHn45QNA7Ft8lFKQx+oLspMvgwXtsboA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X452/INxUGfEavK5sRhInp4oz0sY7Yg0iER6V1KN8QLVdbN6v9Ehjffdj4slCXn6qOmiZ5zaDk6CH/Xm5VFVU5CGjLySD3i84hUzb0pe0hCLZLGQYezVks2e+I3Urz7q0pawubItXJcon3ek7KA3eUU1s7STbfag91sfkIex6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjCtWA55; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjCtWA55"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b9d8122fdso92172051fa.3
        for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 21:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767244901; x=1767849701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffSbuz17L8vVbkn/GTSFMF7fhgC1j9yn2MGyslUVfLA=;
        b=MjCtWA550aEi9VoN7jJW3+GpzpMd+jba2j2dp/QLtSrv0Rs1HP/wonjqCRzenHEfS/
         QGU8wti1FcsVFJhn6kHROxjJpyokCX/gESxP9uvfXbV5jn2BPl3JZSoVgk+0sUHDJNGN
         uxHmibSiNFv4e3HWewDasonzbNusinb/4G2UMddrio+WxJaHrfMsk4zR4cvDyE/P8tEw
         jBRa/X4z+RoSSnLmW1eyTws9ou60BBImtYZSBXq12ZvHcfQIe+HQ4uzV8KFoMMNuJFv/
         UlGznN+vmu20brJjUuZM8+GNKGX6uTvzaJ+KgXutAiqAe0tKvTaE3mkdmo3vObMa0QHg
         nJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767244901; x=1767849701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffSbuz17L8vVbkn/GTSFMF7fhgC1j9yn2MGyslUVfLA=;
        b=s0gxtcNP0ZlZuy2iF5uNcNxMLWzpm/k/zcXHoJ2z2ILGNL7ZCD9pvB6hJ1N/7L02dK
         CVlj2Zht7nGYAUH4mjhqvGN2nm6Djfbp91p/TlXG8FdOAz/OBoLWOKoGFf6Uc2pVe9T5
         jEM8yghtinMI+Ek7+I3B6Rzu375UQsv5Nl2WHPKH0dwqiBp3b0BSKly6+eXJ9iO2KiGy
         dHfpdw+rVgjRIu4TCYy1cxTVwFi7S8Qm4EMwr0XvJxrN8CwTMMB4gQbAJ4PhWJJnYR9h
         faT3StiqrvM93fkVvRep9ZCYMaXg1NEgAbUdCfr6S4/lWSXVxZ2Hb4cBeR+SYs7upkZT
         noFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1X91g2oYZ1sff+5waJgMdJbYyGB29vSptdflLRpAae38EEkHNiJdU++HoUwBJEPf9kpBgW6JaPyP6gTCU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ehNlcTOvP17J1EgSJCF0WT61CVtPPD9fUV0I4EiaMtpuWDys
	fR5AJ1eDhWs3Q6cYepsIc6JChFpUwF0gnk2XhVU2oofg7ChdFjp5ay+w
X-Gm-Gg: AY/fxX7L0QelXDOvcUcarroG0/lPEniMHUVWeFiLMTnPyPCGp0/Xm+WQb2ukIJLVs4E
	bfxg4ssdn5ERmvLwbpbh87PAeY0tFgRx4aonN9DexdmyCJPt1YVW0a+j0uzJTTVfhnoqc1NCIqx
	azlJaTNVynx1kdjD02RrEsIZ0z3cb1K9t2FWbaYp1NjxsHXTJS5csK8d4py79KzFS612MKM0tX9
	RNyxT1zAzCJfNrT1tDpvJH5HlVll4IXQbBYq74/4veCkvpHz/p20Tuurq4RIW8/Pnpbq+5weHio
	KOEzsALR945WG4+WA9A2Vf87cQQPa5HhqBLu8U3w8dfgwstd5tqAFnFfgyjERSVtA0ji8YpaCXW
	hVP9DXeAsFTXh7Zf63GtM3c6QyR+KcQRzaPeLQNFQLSjk2qpNJGtAvVgeHI0PlN54tn1ZKtT05V
	62eKdEcxRDBdoBNv9sxByzsSm1awNxUowOZ66kr7F+Niyw5Y7l2KtkJdnWT1fh5xaKUz9wGSGWI
	P+5xg==
X-Google-Smtp-Source: AGHT+IGLqj0ZDWmmxkTrWd4nad4rwkLFukXDL7htB6nyYsiBPkASQFcnEz38louFRmEn5A9Lzx7JHg==
X-Received: by 2002:a05:651c:221a:b0:37c:c370:60a3 with SMTP id 38308e7fff4ca-38121313ec1mr111357941fa.0.1767244900598;
        Wed, 31 Dec 2025 21:21:40 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (84-253-216-54.bb.dnainternet.fi. [84.253.216.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382861ef4ccsm37064921fa.23.2025.12.31.21.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 21:21:38 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Thu, 01 Jan 2026 07:20:47 +0200
Subject: [PATCH RFC 3/6] rust: WIP: use ThisModule trait for initializing
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-this_module_fix-v1-3-46ae3e5605a0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767244881; l=22402;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=kV4DkY3TtJnlHn45QNA7Ft8lFKQx+oLspMvgwXtsboA=;
 b=+2FpexS0WtXNE6vKdS0mOYAZUdjY2u4guztXgs4ZztyxnPyjmfXSFxqyMMmr8cqDPqCt6c0xm
 d9MHAh93ng1DGDpjRd9emw3nfIsZ0Tg5u1+1FuaRr+ezB4mjh8xqXKZ
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Now that ThisModule is trait we can use it for initializing. This way we
can also use it in const context. This does matter in later on.
---
 drivers/android/binder/rust_binder_main.rs |  2 +-
 drivers/block/rnull/configfs.rs            |  2 +-
 drivers/block/rnull/rnull.rs               |  2 +-
 rust/kernel/auxiliary.rs                   |  9 ++-------
 rust/kernel/configfs.rs                    | 19 +++++++++----------
 rust/kernel/driver.rs                      | 17 +++++------------
 rust/kernel/drm/gem/mod.rs                 |  4 ++--
 rust/kernel/i2c.rs                         |  8 ++------
 rust/kernel/lib.rs                         |  8 ++++----
 rust/kernel/net/phy.rs                     | 16 ++++++++--------
 rust/kernel/pci.rs                         |  9 ++-------
 rust/kernel/platform.rs                    |  9 ++-------
 rust/kernel/usb.rs                         |  9 ++-------
 samples/rust/rust_configfs.rs              |  2 +-
 samples/rust/rust_driver_auxiliary.rs      |  6 +++---
 samples/rust/rust_driver_faux.rs           |  2 +-
 samples/rust/rust_minimal.rs               |  2 +-
 samples/rust/rust_misc_device.rs           |  2 +-
 samples/rust/rust_print_main.rs            |  2 +-
 19 files changed, 49 insertions(+), 81 deletions(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index c79a9e742240..169fe552e32a 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -282,7 +282,7 @@ fn ptr_align(value: usize) -> Option<usize> {
 struct BinderModule {}
 
 impl kernel::Module for BinderModule {
-    fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
+    fn init<M: ThisModule>() -> Result<Self> {
         // SAFETY: The module initializer never runs twice, so we only call this once.
         unsafe { crate::context::CONTEXTS.init() };
 
diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 6713a6d92391..a581c97219c7 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use super::{NullBlkDevice, THIS_MODULE};
+use super::NullBlkDevice;
 use kernel::{
     block::mq::gen_disk::{GenDisk, GenDiskBuilder},
     c_str,
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index a9d5e575a2c4..c9dff74489c1 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -36,7 +36,7 @@ struct NullBlkModule {
 }
 
 impl kernel::InPlaceModule for NullBlkModule {
-    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    fn init<M: ThisModule>() -> impl PinInit<Self, Error> {
         pr_info!("Rust null_blk loaded\n");
 
         try_pin_init!(Self {
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 56f3c180e8f6..323074322505 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -12,7 +12,6 @@
     error::{from_result, to_result, Result},
     prelude::*,
     types::Opaque,
-    ThisModule,
 };
 use core::{
     marker::PhantomData,
@@ -28,11 +27,7 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::auxiliary_driver;
 
-    unsafe fn register(
-        adrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<M: ThisModule>(adrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
         // SAFETY: It's safe to set the fields of `struct auxiliary_driver` on initialization.
         unsafe {
             (*adrv.get()).name = name.as_char_ptr();
@@ -43,7 +38,7 @@ unsafe fn register(
 
         // SAFETY: `adrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
-            bindings::__auxiliary_driver_register(adrv.get(), module.0, name.as_char_ptr())
+            bindings::__auxiliary_driver_register(adrv.get(), M::OWNER.as_ptr(), name.as_char_ptr())
         })
     }
 
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 466fb7f40762..f6f0a32e06d1 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -744,17 +744,17 @@ macro_rules! impl_item_type {
     ($tpe:ty) => {
         impl<Data> ItemType<$tpe, Data> {
             #[doc(hidden)]
-            pub const fn new_with_child_ctor<const N: usize, Child>(
-                owner: &'static ThisModule,
+            pub const fn new_with_child_ctor<const N: usize, Child, M>(
                 attributes: &'static AttributeList<N, Data>,
             ) -> Self
             where
                 Data: GroupOperations<Child = Child>,
                 Child: 'static,
+                M: ThisModule,
             {
                 Self {
                     item_type: Opaque::new(bindings::config_item_type {
-                        ct_owner: owner.as_ptr(),
+                        ct_owner: M::OWNER.as_ptr(),
                         ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr().cast_mut(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
@@ -765,13 +765,12 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
             }
 
             #[doc(hidden)]
-            pub const fn new<const N: usize>(
-                owner: &'static ThisModule,
+            pub const fn new<const N: usize, M: ThisModule>(
                 attributes: &'static AttributeList<N, Data>,
             ) -> Self {
                 Self {
                     item_type: Opaque::new(bindings::config_item_type {
-                        ct_owner: owner.as_ptr(),
+                        ct_owner: M::OWNER.as_ptr(),
                         ct_group_ops: core::ptr::null_mut(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
@@ -1019,8 +1018,8 @@ macro_rules! configfs_attrs {
                     const [<$no_child:upper>]: bool = true;
 
                     static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
-                        $crate::configfs::ItemType::<$container, $data>::new::<N>(
-                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                        $crate::configfs::ItemType::<$container, $data>::new::<N, crate::THIS_MODULE>(
+                            &[<$ data:upper _ATTRS >]
                         );
                 )?
 
@@ -1028,8 +1027,8 @@ macro_rules! configfs_attrs {
                     static [< $data:upper _TPE >]:
                         $crate::configfs::ItemType<$container, $data>  =
                             $crate::configfs::ItemType::<$container, $data>::
-                            new_with_child_ctor::<N, $child>(
-                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                            new_with_child_ctor::<N, $child, crate::THIS_MODULE>(
+                                &[<$ data:upper _ATTRS >]
                             );
                 )?
 
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 9beae2e3d57e..7c4ad24bb48a 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -118,11 +118,7 @@ pub unsafe trait RegistrationOps {
     ///
     /// On success, `reg` must remain pinned and valid until the matching call to
     /// [`RegistrationOps::unregister`].
-    unsafe fn register(
-        reg: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result;
+    unsafe fn register<M: ThisModule>(reg: &Opaque<Self::RegType>, name: &'static CStr) -> Result;
 
     /// Unregisters a driver previously registered with [`RegistrationOps::register`].
     ///
@@ -155,7 +151,7 @@ unsafe impl<T: RegistrationOps> Send for Registration<T> {}
 
 impl<T: RegistrationOps> Registration<T> {
     /// Creates a new instance of the registration object.
-    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    pub fn new<M: ThisModule>(name: &'static CStr) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
             reg <- Opaque::try_ffi_init(|ptr: *mut T::RegType| {
                 // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
@@ -166,7 +162,7 @@ pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Sel
                 let drv = unsafe { &*(ptr as *const Opaque<T::RegType>) };
 
                 // SAFETY: `drv` is guaranteed to be pinned until `T::unregister`.
-                unsafe { T::register(drv, name, module) }
+                unsafe { T::register::<M>(drv, name) }
             }),
         })
     }
@@ -197,13 +193,10 @@ struct DriverModule {
         }
 
         impl $crate::InPlaceModule for DriverModule {
-            fn init(
-                module: &'static $crate::ThisModule
-            ) -> impl ::pin_init::PinInit<Self, $crate::error::Error> {
+            fn init<M: ::kernel::ThisModule>() -> impl ::pin_init::PinInit<Self, $crate::error::Error> {
                 $crate::try_pin_init!(Self {
-                    _driver <- $crate::driver::Registration::new(
+                    _driver <- $crate::driver::Registration::new::<M>(
                         <Self as $crate::ModuleMetadata>::NAME,
-                        module,
                     ),
                 })
             }
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index bdaac839dacc..1d9f78752946 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -292,10 +292,10 @@ impl<T: DriverObject> AllocImpl for Object<T> {
     };
 }
 
-pub(super) const fn create_fops() -> bindings::file_operations {
+pub(super) const fn create_fops<M: ThisModule>() -> bindings::file_operations {
     let mut fops: bindings::file_operations = pin_init::zeroed();
 
-    fops.owner = core::ptr::null_mut();
+    fops.owner = M::OWNER.as_ptr();
     fops.open = Some(bindings::drm_open);
     fops.release = Some(bindings::drm_release);
     fops.unlocked_ioctl = Some(bindings::drm_ioctl);
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 491e6cc25cf4..bc154506b16f 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -97,11 +97,7 @@ macro_rules! i2c_device_table {
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::i2c_driver;
 
-    unsafe fn register(
-        idrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<M: ThisModule>(idrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
         build_assert!(
             T::ACPI_ID_TABLE.is_some() || T::OF_ID_TABLE.is_some() || T::I2C_ID_TABLE.is_some(),
             "At least one of ACPI/OF/Legacy tables must be present when registering an i2c driver"
@@ -134,7 +130,7 @@ unsafe fn register(
         }
 
         // SAFETY: `idrv` is guaranteed to be a valid `RegType`.
-        to_result(unsafe { bindings::i2c_register_driver(module.0, idrv.get()) })
+        to_result(unsafe { bindings::i2c_register_driver(M::OWNER.as_ptr(), idrv.get()) })
     }
 
     unsafe fn unregister(idrv: &Opaque<Self::RegType>) {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 224410745734..6d4563662a02 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -173,7 +173,7 @@ pub trait Module: Sized + Sync + Send {
     /// should do.
     ///
     /// Equivalent to the `module_init` macro in the C API.
-    fn init(module: &'static ThisModule) -> error::Result<Self>;
+    fn init<M: ThisModule>() -> error::Result<Self>;
 }
 
 /// A module that is pinned and initialised in-place.
@@ -181,13 +181,13 @@ pub trait InPlaceModule: Sync + Send {
     /// Creates an initialiser for the module.
     ///
     /// It is called when the module is loaded.
-    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Error>;
+    fn init<M: ThisModule>() -> impl pin_init::PinInit<Self, error::Error>;
 }
 
 impl<T: Module> InPlaceModule for T {
-    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Error> {
+    fn init<M: ThisModule>() -> impl pin_init::PinInit<Self, error::Error> {
         let initer = move |slot: *mut Self| {
-            let m = <Self as Module>::init(module)?;
+            let m = <Self as Module>::init::<M>()?;
 
             // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
             unsafe { slot.write(m) };
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index bf6272d87a7b..5fc90d949d60 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -648,10 +648,7 @@ unsafe impl Send for Registration {}
 
 impl Registration {
     /// Registers a PHY driver.
-    pub fn register(
-        module: &'static crate::ThisModule,
-        drivers: Pin<&'static mut [DriverVTable]>,
-    ) -> Result<Self> {
+    pub fn register<M: ThisModule>(drivers: Pin<&'static mut [DriverVTable]>) -> Result<Self> {
         if drivers.is_empty() {
             return Err(code::EINVAL);
         }
@@ -659,7 +656,11 @@ pub fn register(
         // the `drivers` slice are initialized properly. `drivers` will not be moved.
         // So it's just an FFI call.
         to_result(unsafe {
-            bindings::phy_drivers_register(drivers[0].0.get(), drivers.len().try_into()?, module.0)
+            bindings::phy_drivers_register(
+                drivers[0].0.get(),
+                drivers.len().try_into()?,
+                M::OWNER.as_ptr(),
+            )
         })?;
         // INVARIANT: The `drivers` slice is successfully registered to the kernel via `phy_drivers_register`.
         Ok(Registration { drivers })
@@ -891,12 +892,11 @@ struct Module {
                 [$($crate::net::phy::create_phy_driver::<$driver>()),+];
 
             impl $crate::Module for Module {
-                fn init(module: &'static $crate::ThisModule) -> Result<Self> {
+                fn init<M: $crate::ThisModule>() -> Result<Self> {
                     // SAFETY: The anonymous constant guarantees that nobody else can access
                     // the `DRIVERS` static. The array is used only in the C side.
                     let drivers = unsafe { &mut DRIVERS };
-                    let mut reg = $crate::net::phy::Registration::register(
-                        module,
+                    let mut reg = $crate::net::phy::Registration::register::<M>(
                         ::core::pin::Pin::static_mut(drivers),
                     )?;
                     Ok(Module { _reg: reg })
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 82e128431f08..792560ca8020 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -20,7 +20,6 @@
     prelude::*,
     str::CStr,
     types::Opaque,
-    ThisModule, //
 };
 use core::{
     marker::PhantomData,
@@ -55,11 +54,7 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::pci_driver;
 
-    unsafe fn register(
-        pdrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<M: ThisModule>(pdrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
         // SAFETY: It's safe to set the fields of `struct pci_driver` on initialization.
         unsafe {
             (*pdrv.get()).name = name.as_char_ptr();
@@ -70,7 +65,7 @@ unsafe fn register(
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
-            bindings::__pci_register_driver(pdrv.get(), module.0, name.as_char_ptr())
+            bindings::__pci_register_driver(pdrv.get(), M::OWNER.as_ptr(), name.as_char_ptr())
         })
     }
 
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index ed889f079cab..67d46231600e 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -14,7 +14,6 @@
     of,
     prelude::*,
     types::Opaque,
-    ThisModule,
 };
 
 use core::{
@@ -31,11 +30,7 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::platform_driver;
 
-    unsafe fn register(
-        pdrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<M: ThisModule>(pdrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
         let of_table = match T::OF_ID_TABLE {
             Some(table) => table.as_ptr(),
             None => core::ptr::null(),
@@ -56,7 +51,7 @@ unsafe fn register(
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
-        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) })
+        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), M::OWNER.as_ptr()) })
     }
 
     unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index d10b65e9fb6a..c6ee98d12875 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -13,7 +13,6 @@
     prelude::*,
     str::CStr,
     types::{AlwaysRefCounted, Opaque},
-    ThisModule,
 };
 use core::{
     marker::PhantomData,
@@ -32,11 +31,7 @@
 unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::usb_driver;
 
-    unsafe fn register(
-        udrv: &Opaque<Self::RegType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
+    unsafe fn register<M: ThisModule>(udrv: &Opaque<Self::RegType>, name: &'static CStr) -> Result {
         // SAFETY: It's safe to set the fields of `struct usb_driver` on initialization.
         unsafe {
             (*udrv.get()).name = name.as_char_ptr();
@@ -47,7 +42,7 @@ unsafe fn register(
 
         // SAFETY: `udrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
-            bindings::usb_register_driver(udrv.get(), module.0, name.as_char_ptr())
+            bindings::usb_register_driver(udrv.get(), M::OWNER.as_ptr(), name.as_char_ptr())
         })
     }
 
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index 0ccc7553ef39..858b2a45238d 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -42,7 +42,7 @@ fn new() -> impl PinInit<Self, Error> {
 }
 
 impl kernel::InPlaceModule for RustConfigfs {
-    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    fn init<M: ThisModule>() -> impl PinInit<Self, Error> {
         pr_info!("Rust configfs sample (init)\n");
 
         // Define a subsystem with the data type `Configuration`, two
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 5761ea314f44..e996dca19454 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -111,10 +111,10 @@ struct SampleModule {
 }
 
 impl InPlaceModule for SampleModule {
-    fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
+    fn init<M: ThisModule>() -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
-            _pci_driver <- driver::Registration::new(MODULE_NAME, module),
-            _aux_driver <- driver::Registration::new(MODULE_NAME, module),
+            _pci_driver <- driver::Registration::new::<M>(MODULE_NAME),
+            _aux_driver <- driver::Registration::new::<M>(MODULE_NAME),
         })
     }
 }
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index ecc9fd378cbd..f66452c0390c 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -17,7 +17,7 @@ struct SampleModule {
 }
 
 impl Module for SampleModule {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init<M: kernel::ThisModule>() -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
 
         let reg = faux::Registration::new(c_str!("rust-faux-sample-device"), None)?;
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 8eb9583571d7..c3696e69d67b 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -23,7 +23,7 @@ struct RustMinimal {
 }
 
 impl kernel::Module for RustMinimal {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init<M: kernel::ThisModule>() -> Result<Self> {
         pr_info!("Rust minimal sample (init)\n");
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
         pr_info!(
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index d69bc33dbd99..3f1acb6818a5 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -129,7 +129,7 @@ struct RustMiscDeviceModule {
 }
 
 impl kernel::InPlaceModule for RustMiscDeviceModule {
-    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    fn init<M: ThisModule>() -> impl PinInit<Self, Error> {
         pr_info!("Initialising Rust Misc Device Sample\n");
 
         let options = MiscDeviceOptions {
diff --git a/samples/rust/rust_print_main.rs b/samples/rust/rust_print_main.rs
index 4095c72afeab..b60ff0683a0e 100644
--- a/samples/rust/rust_print_main.rs
+++ b/samples/rust/rust_print_main.rs
@@ -59,7 +59,7 @@ fn arc_dyn_print(arc: &Arc<dyn Display>) {
 }
 
 impl kernel::Module for RustPrint {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init<M: kernel::ThisModule>() -> Result<Self> {
         pr_info!("Rust printing macros sample (init)\n");
 
         pr_emerg!("Emergency message (level 0) without args\n");

-- 
2.43.0

