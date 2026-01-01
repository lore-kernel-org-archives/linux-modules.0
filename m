Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D2242D7D
	for <linux-modules@vger.kernel.org>; Thu,  1 Jan 2026 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767244910; cv=none; b=bNMozKjvxRnaDFq5gi0Uue+C78JVWyQe0svo5VJWj1LCZRRFP5Gx/X7K26g6V4iJ3yJQ2cYZNn2N5TihAsZboykyckOHPwOIITIdY91jTX9f4Q0Dj3oSuog1E8qUt3icj6hIUk9hHpyqF1PmOhdoAI98/UfwILdv1zRTPiyx0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767244910; c=relaxed/simple;
	bh=nhvDkK7TuHB4MoV4yw6dY467Y+N4XGakk6DbHpWFzd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQBnmgk3CaPo8ZKTOychHdHQScpl34rVqKl7mMnQMWkDtGMyW+uUaWXDpx9J9xze9nPdqmW75EnW5Vc7Xt7DHRD5eeOt2VotWBoTZczuuZNbIuNpNH3vhF3Ece6zvjTV7vIe1U2In0lN7tLeE0QGLg+M9fVpMXQEtSFpqqhzDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ju6NoZ4E; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju6NoZ4E"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5958931c9c7so12853545e87.2
        for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 21:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767244906; x=1767849706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/ANztT2H+RPjRwH4Tsn7VpWSZebBDPsBIwtoPyunNo=;
        b=Ju6NoZ4EdUJ+YcU0nQtl91qWUEYRJuGnIbFyD3FiTNgEkRoOyXqroW4QNht0iT1aTI
         g0d/UDJPPHEjG0wXPV2QlVtx6UT63rTdMdj0sfDKHRXZ0vSeoNRVx3vT/1Qa8Vuivht1
         bC9VDDwNFuOT9wdwhaRh9fp2+kGr3O7OehBa/mNDhrEoagdnICeAIb/vjoQuGyt6qFAJ
         lgJ//1q7IohtPGMD+a+yANVugBoT0MPVUiwatSPy7UC4cten2Xk8OC9gMoOhu1IA8+Z4
         TDD/t3pqMiA1XkhSvguINfHYVeB7aEkVGWtDuzozRyiEk2LmpD87gD17MqZKfOEmZCK7
         VYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767244906; x=1767849706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m/ANztT2H+RPjRwH4Tsn7VpWSZebBDPsBIwtoPyunNo=;
        b=PloOAu1TKSY63dKnMRrltTRjMI1ZoMNLymfKGNAre4VxVTyPW93++Mc+QSF2KjWAPv
         5W372Oe/Zq6g3VxS8P6qOOHyzsrRhBGMr8Weesji0xJUy5Pgnum3BQ9VQ81IzablZWgb
         Wiu00QY7ZAJ7/yyKYqXTfbhjQR8GyqG2O+nsBfNZ3Zwx5VrRQil/DfnysyZnSkSdEOC+
         2Xz2GY5mGT+7dAeo11jfHHW+khnPaPPEwokXcgGW70SrmStUs3RYHcW0RKFeNPSYJ6PN
         QEwyTSbhObnDqI867XGLVCtNiygAPlDizlwAQ6zwpxSZEqqGKmlUoo0XvYxgmSJ1r1gs
         KUFg==
X-Forwarded-Encrypted: i=1; AJvYcCUX7AWk4Ytmo1P2YWh3s9RqQkp3QRua+kTq0WGAxAwPt+bB0lENzTe4BTNWUyeRcDwOEQwcJQRhjbxOCEql@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3gdfmZP+t6oqiaSICVerW0AL/F69H/u6FxidqFPm5aQ5iY2SH
	nRWi8wtQfdc9yYFEj/PZoV7djA2xDBcLsBpmtMa20o0JTzZBjTleLkKB
X-Gm-Gg: AY/fxX6o11l6Gdd4ljJsJH2CnSy+rY3Htd+ic3pNKkUiOynA6aZNhJEMl7nA2BhuGQm
	DG1yf0BPicJU3x3j6Hur4ZpjGb+isOY5ybkm8NDg2FzIhcw8JKA94JVWuWtpKdrD6LY/en+FoH9
	E5a61kt4obZBbsNa/oAsDEIUrkPRsaPmY/4z7yihX5mlDW3y/FATd6ImN6zYBXBIJioPc9HdWEV
	bJkgazOwo48BwpJ30EukYIQ+Z9PsIHA/HpZCSapJAuqLBGqHIjVEixxCUFIniEc+moxSeUSNke9
	UB4yngLReSqtaHUZHiaXfS3WDHGrBpo7x6U5KTuyhnO/PY8N3wyaXI5RTLatPAnbgvnx6yGPHKc
	P0COXnV/xY71VHv9q9ScbqzPEqkC14QUErjdqLLSx6hx7dsyEfSJIrpxFpxwBwk0szdrla9jDps
	gXewlGrxbHV7ja4VEitptyd58gtjqcpIsJqusuGOhECiFPt9szuIVm2jcDH+YGzZaqMiTyJlB6V
	XIjBA==
X-Google-Smtp-Source: AGHT+IEY8zKF0VLVmG6TtPAYOSCfHkImpLYAYGmmru2k+1hlQ5fmMzzDNTll7nlIB5lVGkBEHsJVnA==
X-Received: by 2002:a05:6512:131c:b0:593:ffa:6988 with SMTP id 2adb3069b0e04-59a17d9707fmr13645549e87.21.1767244905984;
        Wed, 31 Dec 2025 21:21:45 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (84-253-216-54.bb.dnainternet.fi. [84.253.216.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382861ef4ccsm37064921fa.23.2025.12.31.21.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 21:21:43 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Thu, 01 Jan 2026 07:20:48 +0200
Subject: [PATCH RFC 4/6] rust: WIP: use ThisModule trait to fix some
 missing owners
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-this_module_fix-v1-4-46ae3e5605a0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767244881; l=9015;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=nhvDkK7TuHB4MoV4yw6dY467Y+N4XGakk6DbHpWFzd0=;
 b=LQy58ByfuHjMPZSnA9a2ozCKWq2Y3Fs4/M6Cjv7nmjYk01qfXvfcVsmWkq4egQIxeok8J69Op
 Z2gArtuoOyuBaqKqaIIhTViELLVZ9f5EjAfc727JvOm0cfPtMH4Kwtm
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Some places do not define owner and we have null pointer dereference
bugs which we can fix with this. I have tested miscdevice that it
actually works.
---
 drivers/android/binder/rust_binder_main.rs |  2 +-
 drivers/block/rnull/rnull.rs               |  1 +
 drivers/gpu/drm/nova/driver.rs             |  1 +
 drivers/gpu/drm/tyr/driver.rs              |  1 +
 lib/find_bit_benchmark_rust.rs             |  2 +-
 rust/kernel/block/mq/gen_disk.rs           | 31 ++++--------------------------
 rust/kernel/block/mq/operations.rs         | 12 ++++++++++++
 rust/kernel/drm/device.rs                  |  2 +-
 rust/kernel/drm/driver.rs                  |  3 +++
 rust/kernel/miscdevice.rs                  |  4 ++++
 samples/rust/rust_misc_device.rs           |  1 +
 11 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index 169fe552e32a..7877503c639e 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -311,7 +311,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
     let zeroed_ops = unsafe { core::mem::MaybeUninit::zeroed().assume_init() };
 
     let ops = kernel::bindings::file_operations {
-        owner: THIS_MODULE.as_ptr(),
+        owner: <THIS_MODULE as ThisModule>::OWNER.as_ptr(),
         poll: Some(rust_binder_poll),
         unlocked_ioctl: Some(rust_binder_ioctl),
         compat_ioctl: Some(bindings::compat_ptr_ioctl),
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index c9dff74489c1..3360a0f50fc6 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -75,6 +75,7 @@ struct QueueData {
 #[vtable]
 impl Operations for NullBlkDevice {
     type QueueData = KBox<QueueData>;
+    type ThisModule = THIS_MODULE;
 
     #[inline(always)]
     fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 2246d8e104e0..a49c9848ce2e 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -57,6 +57,7 @@ fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<S
 
 #[vtable]
 impl drm::Driver for NovaDriver {
+    type ThisModule = crate::THIS_MODULE;
     type Data = NovaData;
     type File = File;
     type Object = gem::Object<NovaObject>;
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 264c2362237a..a84825dbd008 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -180,6 +180,7 @@ fn drop(self: Pin<&mut Self>) {
 
 #[vtable]
 impl drm::Driver for TyrDriver {
+    type ThisModule = crate::THIS_MODULE;
     type Data = TyrData;
     type File = File;
     type Object = drm::gem::Object<TyrObject>;
diff --git a/lib/find_bit_benchmark_rust.rs b/lib/find_bit_benchmark_rust.rs
index 6bdc51de2f30..420a1855b08a 100644
--- a/lib/find_bit_benchmark_rust.rs
+++ b/lib/find_bit_benchmark_rust.rs
@@ -88,7 +88,7 @@ fn find_bit_test() {
 }
 
 impl kernel::Module for Benchmark {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init<M: ThisModule>() -> Result<Self> {
         find_bit_test();
         // Return error so test module can be inserted again without rmmod.
         Err(code::EINVAL)
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 1ce815c8cdab..f5839829d0b7 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,7 +7,7 @@
 
 use crate::{
     bindings,
-    block::mq::{Operations, TagSet},
+    block::mq::{operations::OperationsVTable, Operations, TagSet},
     error::{self, from_err_ptr, Result},
     fmt::{self, Write},
     prelude::*,
@@ -126,32 +126,9 @@ pub fn build<T: Operations>(
             )
         })?;
 
-        const TABLE: bindings::block_device_operations = bindings::block_device_operations {
-            submit_bio: None,
-            open: None,
-            release: None,
-            ioctl: None,
-            compat_ioctl: None,
-            check_events: None,
-            unlock_native_capacity: None,
-            getgeo: None,
-            set_read_only: None,
-            swap_slot_free_notify: None,
-            report_zones: None,
-            devnode: None,
-            alternative_gpt_sector: None,
-            get_unique_id: None,
-            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_static feature to
-            // be merged (unstable in rustc 1.78 which is staged for linux 6.10)
-            // <https://github.com/rust-lang/rust/issues/119618>
-            owner: core::ptr::null_mut(),
-            pr_ops: core::ptr::null_mut(),
-            free_disk: None,
-            poll_bio: None,
-        };
-
-        // SAFETY: `gendisk` is a valid pointer as we initialized it above
-        unsafe { (*gendisk).fops = &TABLE };
+        unsafe {
+            (*gendisk).fops = OperationsVTable::<T>::build_block_device_operations();
+        }
 
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 8ad46129a52c..3e0e8baa7d07 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -31,6 +31,8 @@ pub trait Operations: Sized {
     /// Data associated with the `struct request_queue` that is allocated for
     /// the `GenDisk` associated with this `Operations` implementation.
     type QueueData: ForeignOwnable;
+    /// TODO Doc
+    type ThisModule: ThisModule;
 
     /// Called by the kernel to queue a request with the driver. If `is_last` is
     /// `false`, the driver is allowed to defer committing the request.
@@ -283,4 +285,14 @@ impl<T: Operations> OperationsVTable<T> {
     pub(crate) const fn build() -> &'static bindings::blk_mq_ops {
         &Self::VTABLE
     }
+
+    const BLOCK_OPS: bindings::block_device_operations = bindings::block_device_operations {
+        owner: T::ThisModule::OWNER.as_ptr(),
+        ..pin_init::zeroed()
+    };
+
+    pub(crate) const fn build_block_device_operations() -> &'static bindings::block_device_operations
+    {
+        &Self::BLOCK_OPS
+    }
 }
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 3ce8f62a0056..a740c87933d0 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -92,7 +92,7 @@ impl<T: drm::Driver> Device<T> {
         fops: &Self::GEM_FOPS,
     };
 
-    const GEM_FOPS: bindings::file_operations = drm::gem::create_fops();
+    const GEM_FOPS: bindings::file_operations = drm::gem::create_fops::<T::ThisModule>();
 
     /// Create a new `drm::Device` for a `drm::Driver`.
     pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<ARef<Self>> {
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index f30ee4c6245c..ae8f7d3b9156 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -99,6 +99,9 @@ pub trait AllocImpl: super::private::Sealed + drm::gem::IntoGEMObject {
 /// drm_driver` to be registered in the DRM subsystem.
 #[vtable]
 pub trait Driver {
+    /// TODO Doc
+    type ThisModule: ThisModule;
+
     /// Context data associated with the DRM driver
     type Data: Sync + Send;
 
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index d698cddcb4a5..08346c52d574 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -116,6 +116,9 @@ pub trait MiscDevice: Sized {
     /// What kind of pointer should `Self` be wrapped in.
     type Ptr: ForeignOwnable + Send + Sync;
 
+    /// TODO Docs
+    type ThisModule: ThisModule;
+
     /// Called when the misc device is opened.
     ///
     /// The returned pointer will be stored as the private data for the file.
@@ -389,6 +392,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     }
 
     const VTABLE: bindings::file_operations = bindings::file_operations {
+        owner: T::ThisModule::OWNER.as_ptr(),
         open: Some(Self::open),
         release: Some(Self::release),
         mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 3f1acb6818a5..78d239b26dcc 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -157,6 +157,7 @@ struct RustMiscDevice {
 #[vtable]
 impl MiscDevice for RustMiscDevice {
     type Ptr = Pin<KBox<Self>>;
+    type ThisModule = THIS_MODULE;
 
     fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Self>>> {
         let dev = ARef::from(misc.device());

-- 
2.43.0

