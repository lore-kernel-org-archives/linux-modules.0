Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501D339855
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716009; cv=none; b=RYLkeB70svahmTm15GNvS92V+filLjW42DfiLwPxTD8KeUCQyZczB4eMO5uTJ13KlQNKghzV0uqJ+Fs5QETqzciJxT5jHKOscydoAuG1QCKdyHcPHJdzSKuQLWWKOipEjw5wgQN++I46sEm4nZ18txhK0E8vqlc7F1F2S/zzURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716009; c=relaxed/simple;
	bh=ux96t37i0o+XQz9rwL1Xsqa9o9j/lFq1tZiPHrrgcfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJc95pOO78BjaSPafBBEzPMxyf0VfKyFyvYlibcKImEGL0l8h0xm66OxB8Tms8kJQCxaVScCwUxwA4WwHxsQ466Uk0bn/sDskhbdXmxEd/qRpIUHQV55ioMhP75mv3rXwTTBuaCkfvefoM146k4Cjjn3yE4y+U2iUCQNpXnu7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh/guTD+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh/guTD+"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b935df7bfso10267361fa.2
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767716005; x=1768320805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/r3EYPU9S+RKnAFCMdSg0qTpeqQzdmOVqZdf6MJWDc=;
        b=eh/guTD+R/aW9TmdqdN+G0xMr3EUdjtMAMnFOUQAH7peyukSZ9mh4WdV5bTMytjsWy
         IiT9jafeNhcRsajEdIG/igU7fugiIzm23MwAg/RRiG/rpf6lYFiIc1xFon8fM+GevNR1
         FvyH88Zy31lmVIW/tl3Fjo8vfjI7RSJxhC2c33dJ88R3FugEmUfpbn2PxdsD8w/E8ciP
         09D1sL3mXlDoP2kuh1R7eEuIsuYny+vugRCJJWoQy81WSG5Er3loWOCSlTlU/LNTFiSt
         CHQAnAW5cpGCXrLrpI+xhWU1UmN4DOIlbIhCVFh8hncwwYNbVT9PPCHp41j7SOyVbrsE
         ZAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716005; x=1768320805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w/r3EYPU9S+RKnAFCMdSg0qTpeqQzdmOVqZdf6MJWDc=;
        b=jhJiwsyRWMkekbjGjH1zPXA8x4pxbOS9zCpMqjVbb/KVv1ea/SnPHqSUMiNt4FE6QE
         me0JJDqMzadLsOQuSjaE1WxfE0XfnqrL/TcFwuyewedWtAxLMsIz5EhZMUXl3km5wS9B
         ULgLYxV1p94ay3npFaU0vJfld2BkbRgPTEKHONKt6bPyCiviRzNBwQ2nn53U5l9BIacN
         Nlm8zB6HFCL/fHUgn09bwlT/V3kQebjn0lgNLcc3FPzmYbwIbzlo8FVbv70JYTPVvCcS
         HOPBPVQzQkXWMVQ2ItDVGiiFUz3hTed6hM+bQdV+1tIhnrq85Xp5AJOMBES3WK1UcBw5
         /LUA==
X-Forwarded-Encrypted: i=1; AJvYcCWgY/7FkjxWMbhn2Nk2dubzpMR/9YcfZpspcJ6o3N00lfgb6Uvi3dRRB59P1mDbTMezjdjabO2+XGZONC+O@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gCNUjke0UzL8REWVYigU1FbZ6QR0k729tYoCcmo9h/lQ6IZo
	zduUpCyHXejC4BNmZMbWW+f9Z3nVhS9oGyJIZat4N8410le+GyUCmtne
X-Gm-Gg: AY/fxX64PoKZUGIExVVkGHinsDYpD2j9B4pOW1W6mh7KW4a1nfIGUlN8Ki5UdSSdTGs
	EtmAe/HSUIlOjx37Vvm5qhNFkSumDwTfMsODHZfVRoUj1tdONNDsAeONVldOjYkbUqhFV2sTl8/
	db6MpcunKDZ+xbQHsKvmaVUSD6ISI92KF62+7ZibYU0UItNO9d79u0k6YC+vXu9TQ/Au4iFwE4P
	4R2mDIuYt04b2QG6cYq47gbp1p3Ez+nadOLsP0A77B9e/LYwNrmVwzKSZI41n1dPBxWtXTr93EU
	wg5i2OYZK0zg6LEJHK2in0VgwBuulbEtQyL+ScfDhPnzvAL0ViF/+pgFI2Wm0geQTl8WXbVM8Ri
	eloeKBuAOIuMmR1Ycp+TD5K86Wn3KNMIyo3Nu7FB8FABPaAF01MXgeZuiYCruCRVSen4dpYboed
	MR6uuGHIjhZgMKtAX7OkudZK8jUrdXrduov5eMg6IwDaTUkHbpAvytrcMCuzoj+YNEyF1LmE0e6
	4mATJDKjOfEd0uI
X-Google-Smtp-Source: AGHT+IGYZWam7DBChjxOUl3CONwCvShE1fvapEpMsDYCfGaWU3TWsq5laWGyI8gsXTyWYvUHcv79Mg==
X-Received: by 2002:a05:651c:221a:b0:37a:30c5:af1f with SMTP id 38308e7fff4ca-382eaadb376mr11103641fa.40.1767716004648;
        Tue, 06 Jan 2026 08:13:24 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:24 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:47 +0200
Subject: [PATCH RFC v2 09/11] rust: remove module argument from
 InPlaceModule::init()
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-this_module_fix-v2-9-842ac026f00b@gmail.com>
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
 Kari Argillander <kari.argillander@gmail.com>, 
 Yuheng Su <gipsyh.icu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=13585;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=ux96t37i0o+XQz9rwL1Xsqa9o9j/lFq1tZiPHrrgcfg=;
 b=rRmm6X7wAsFkyggSVE85WlCCByCGyW2Uik6XNWiq6PaAnJGJIKLtaD+udyDf5v2FSjJoAgZ2i
 VBkL++c3BLZBdhAJJP5v/pWpv3oxK1lhXckuofLLPSz1HXQM5ZA9M3q
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

InPlaceModule::init() has ThisModule argument. However modules always
have THIS_MODULE made by module! macro. So it is unnecessary to pass
same information through this function. End goal is to make idea of
THIS_MODULE simpler. Driver getting this THIS_MODULE from multiple
places is confusing. So let's just stick with THIS_MODULE as that also
works in const context very easily.

Reported-by: Yuheng Su <gipsyh.icu@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/720
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/android/binder/rust_binder_main.rs | 2 +-
 drivers/block/rnull/rnull.rs               | 2 +-
 lib/find_bit_benchmark_rust.rs             | 3 +--
 rust/kernel/configfs.rs                    | 3 +--
 rust/kernel/driver.rs                      | 4 +---
 rust/kernel/firmware.rs                    | 2 +-
 rust/kernel/lib.rs                         | 8 ++++----
 rust/kernel/net/phy.rs                     | 2 +-
 rust/kernel/sync/lock/global.rs            | 4 ++--
 rust/macros/lib.rs                         | 4 ++--
 rust/macros/module.rs                      | 2 +-
 samples/rust/rust_configfs.rs              | 2 +-
 samples/rust/rust_debugfs_scoped.rs        | 2 +-
 samples/rust/rust_driver_auxiliary.rs      | 2 +-
 samples/rust/rust_driver_faux.rs           | 2 +-
 samples/rust/rust_minimal.rs               | 2 +-
 samples/rust/rust_misc_device.rs           | 2 +-
 samples/rust/rust_print_main.rs            | 2 +-
 18 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index fc921c0e1116..8b865112e60c 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -291,7 +291,7 @@ fn ptr_align(value: usize) -> Option<usize> {
 struct BinderModule {}
 
 impl kernel::Module for BinderModule {
-    fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
+    fn init() -> Result<Self> {
         // SAFETY: The module initializer never runs twice, so we only call this once.
         unsafe { crate::context::CONTEXTS.init() };
 
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 862369ab9b5c..a9be1b2187f4 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -36,7 +36,7 @@ struct NullBlkModule {
 }
 
 impl kernel::InPlaceModule for NullBlkModule {
-    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    fn init() -> impl PinInit<Self, Error> {
         pr_info!("Rust null_blk loaded\n");
 
         try_pin_init!(Self {
diff --git a/lib/find_bit_benchmark_rust.rs b/lib/find_bit_benchmark_rust.rs
index 6bdc51de2f30..5c231569d887 100644
--- a/lib/find_bit_benchmark_rust.rs
+++ b/lib/find_bit_benchmark_rust.rs
@@ -7,7 +7,6 @@
 use kernel::error::{code, Result};
 use kernel::prelude::module;
 use kernel::time::{Instant, Monotonic};
-use kernel::ThisModule;
 use kernel::{pr_cont, pr_err};
 
 const BITMAP_LEN: usize = 4096 * 8 * 10;
@@ -88,7 +87,7 @@ fn find_bit_test() {
 }
 
 impl kernel::Module for Benchmark {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init() -> Result<Self> {
         find_bit_test();
         // Return error so test module can be inserted again without rmmod.
         Err(code::EINVAL)
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 908cb98d404f..2af63f7daef2 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -27,7 +27,6 @@
 //! use kernel::new_mutex;
 //! use kernel::page::PAGE_SIZE;
 //! use kernel::sync::Mutex;
-//! use kernel::ThisModule;
 //!
 //! #[pin_data]
 //! struct RustConfigfs {
@@ -36,7 +35,7 @@
 //! }
 //!
 //! impl kernel::InPlaceModule for RustConfigfs {
-//!     fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+//!     fn init() -> impl PinInit<Self, Error> {
 //!         pr_info!("Rust configfs sample (init)\n");
 //!
 //!         let item_type = configfs_attrs! {
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index dc7522c4ebda..de77f95d7fe0 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -201,9 +201,7 @@ struct DriverModule {
         }
 
         impl $crate::InPlaceModule for DriverModule {
-            fn init(
-                _module: &'static $crate::ThisModule
-            ) -> impl ::pin_init::PinInit<Self, $crate::error::Error> {
+            fn init() -> impl ::pin_init::PinInit<Self, $crate::error::Error> {
                 $crate::try_pin_init!(Self {
                     _driver <- $crate::driver::Registration::new::<crate::THIS_MODULE>(),
                 })
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 71168d8004e2..11372a8f7be4 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -157,7 +157,7 @@ unsafe impl Sync for Firmware {}
 /// # struct MyModule;
 /// #
 /// # impl kernel::Module for MyModule {
-/// #     fn init(_module: &'static ThisModule) -> Result<Self> {
+/// #     fn init() -> Result<Self> {
 /// #         Ok(Self)
 /// #     }
 /// # }
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 2ccd75f68f03..e7bc52a6ad42 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -175,7 +175,7 @@ pub trait Module: Sized + Sync + Send {
     /// should do.
     ///
     /// Equivalent to the `module_init` macro in the C API.
-    fn init(module: &'static ThisModule) -> error::Result<Self>;
+    fn init() -> error::Result<Self>;
 }
 
 /// A module that is pinned and initialised in-place.
@@ -183,13 +183,13 @@ pub trait InPlaceModule: Sync + Send {
     /// Creates an initialiser for the module.
     ///
     /// It is called when the module is loaded.
-    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Error>;
+    fn init() -> impl pin_init::PinInit<Self, error::Error>;
 }
 
 impl<T: Module> InPlaceModule for T {
-    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Error> {
+    fn init() -> impl pin_init::PinInit<Self, error::Error> {
         let initer = move |slot: *mut Self| {
-            let m = <Self as Module>::init(module)?;
+            let m = <Self as Module>::init()?;
 
             // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
             unsafe { slot.write(m) };
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index b6c99bf7e97b..7d467d42e951 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -901,7 +901,7 @@ struct Module {
                 [$($crate::net::phy::create_phy_driver::<$driver>()),+];
 
             impl $crate::Module for Module {
-                fn init(_module: &'static $crate::ThisModule) -> Result<Self> {
+                fn init() -> Result<Self> {
                     // SAFETY: The anonymous constant guarantees that nobody else can access
                     // the `DRIVERS` static. The array is used only in the C side.
                     let drivers = unsafe { &mut DRIVERS };
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index eab48108a4ae..7fde464462d1 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -203,7 +203,7 @@ pub fn get_mut(&mut self) -> &mut T {
 /// }
 ///
 /// impl kernel::Module for MyModule {
-///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///     fn init() -> Result<Self> {
 ///         // SAFETY: Called exactly once.
 ///         unsafe { MY_COUNTER.init() };
 ///
@@ -243,7 +243,7 @@ pub fn get_mut(&mut self) -> &mut T {
 /// }
 ///
 /// impl kernel::Module for MyModule {
-///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///     fn init() -> Result<Self> {
 ///         // SAFETY: Called exactly once.
 ///         unsafe { MY_MUTEX.init() };
 ///
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index b38002151871..d22a93696209 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -80,7 +80,7 @@
 /// struct MyModule(i32);
 ///
 /// impl kernel::Module for MyModule {
-///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///     fn init() -> Result<Self> {
 ///         let foo: i32 = 42;
 ///         pr_info!("I contain:  {}\n", foo);
 ///         pr_info!("i32 param is:  {}\n", module_parameters::my_parameter.read());
@@ -114,7 +114,7 @@
 /// struct MyDeviceDriverModule;
 ///
 /// impl kernel::Module for MyDeviceDriverModule {
-///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///     fn init() -> Result<Self> {
 ///         Ok(Self)
 ///     }
 /// }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 1bcd703735fe..7473a377a3bd 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -490,7 +490,7 @@ mod __module_init {{
                     /// This function must only be called once.
                     unsafe fn __init() -> ::kernel::ffi::c_int {{
                         let initer =
-                            <{type_} as ::kernel::InPlaceModule>::init(&super::super::THIS_MODULE.as_ref());
+                            <{type_} as ::kernel::InPlaceModule>::init();
                         // SAFETY: No data race, since `__MOD` can only be accessed by this module
                         // and there only `__init` and `__exit` access it. These functions are only
                         // called once and `__exit` cannot be called before or during `__init`.
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index 0ccc7553ef39..f34260793677 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -42,7 +42,7 @@ fn new() -> impl PinInit<Self, Error> {
 }
 
 impl kernel::InPlaceModule for RustConfigfs {
-    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    fn init() -> impl PinInit<Self, Error> {
         pr_info!("Rust configfs sample (init)\n");
 
         // Define a subsystem with the data type `Configuration`, two
diff --git a/samples/rust/rust_debugfs_scoped.rs b/samples/rust/rust_debugfs_scoped.rs
index 6a575a15a2c2..75897e02766b 100644
--- a/samples/rust/rust_debugfs_scoped.rs
+++ b/samples/rust/rust_debugfs_scoped.rs
@@ -134,7 +134,7 @@ fn init_control(base_dir: &Dir, dyn_dirs: Dir) -> impl PinInit<Scope<ModuleData>
 }
 
 impl kernel::Module for RustScopedDebugFs {
-    fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
+    fn init() -> Result<Self> {
         let base_dir = Dir::new(c"rust_scoped_debugfs");
         let dyn_dirs = base_dir.subdir(c"dynamic");
         Ok(Self {
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 28a25e540298..7b729687811d 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -111,7 +111,7 @@ struct SampleModule {
 }
 
 impl InPlaceModule for SampleModule {
-    fn init(_module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
+    fn init() -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
             _pci_driver <- driver::Registration::new::<THIS_MODULE>(),
             _aux_driver <- driver::Registration::new::<THIS_MODULE>(),
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index 5330b77ea986..2653b2ec3338 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -21,7 +21,7 @@ struct SampleModule {
 }
 
 impl Module for SampleModule {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init() -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
 
         let reg = faux::Registration::new(c"rust-faux-sample-device", None)?;
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 8eb9583571d7..c024f8083499 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -23,7 +23,7 @@ struct RustMinimal {
 }
 
 impl kernel::Module for RustMinimal {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init() -> Result<Self> {
         pr_info!("Rust minimal sample (init)\n");
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
         pr_info!(
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 464e3026e6e3..709adf4a6026 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -128,7 +128,7 @@ struct RustMiscDeviceModule {
 }
 
 impl kernel::InPlaceModule for RustMiscDeviceModule {
-    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    fn init() -> impl PinInit<Self, Error> {
         pr_info!("Initialising Rust Misc Device Sample\n");
 
         let options = MiscDeviceOptions {
diff --git a/samples/rust/rust_print_main.rs b/samples/rust/rust_print_main.rs
index 4095c72afeab..de1bf7b80153 100644
--- a/samples/rust/rust_print_main.rs
+++ b/samples/rust/rust_print_main.rs
@@ -59,7 +59,7 @@ fn arc_dyn_print(arc: &Arc<dyn Display>) {
 }
 
 impl kernel::Module for RustPrint {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init() -> Result<Self> {
         pr_info!("Rust printing macros sample (init)\n");
 
         pr_emerg!("Emergency message (level 0) without args\n");

-- 
2.43.0

