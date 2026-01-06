Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B625F798
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715994; cv=none; b=qqDc9RQT19bv0W1Zu2+tFpLbxHhsi468UsM1z/ZuAl7dwx32napY4J4nFyhRKaLlsjy++Ydk16LFccf1csfciZJ7bI62b7A+xY5IEwIQLE2Vmg44IRYT3mDpuq6oG1IuG9+5ppyJKw6cQcVkGRUqlvGcbuGzHzb6ixohn1kqHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715994; c=relaxed/simple;
	bh=/Ms0ilmTmhT/+pTanvifPfpMypKbgHczZgI+jrgEiCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2wXIi/pY72WK6PnsONXTDZ7nE6IDU8nZSNN7PrOfoHiMzxtKRKcPYDpqXG45ZmzjzAacWqbCHSY0sBNjoMDn7jfEpgKd3C0ApDM+a2GJTXbaKCXef5DB4A4uJqwuJLEgyEBE6eLTPWUV+blEPM90FVdbpFJ8x3+kBu+5S7njUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwiw2qGL; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwiw2qGL"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37b95f87d4eso10610961fa.1
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767715990; x=1768320790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDBwaX2tbeEhZrSwSpdBrEdEsO8lUCzTxea91t7m1AM=;
        b=lwiw2qGLxAngZQU7k6WuVQ6LPcoxhICXf6Nser9Y5SGkVXmk0jeEifxgMn6Mn+F9Q/
         4WwtIsDGlwEKTm1TpsYTQC20xTxHveT++jKLJP1OcRXfkwr71ed0dn6UU7cgVrf6GdyM
         uczK9C9iDU6BWRj/8hpcqBi5OrP/pPmJCN22nDwRlRHQhOCSrpQMh9sb4vMCaidJKXq3
         1mJqyEP/rOJ+KL+R3pG4bFdQW8Bx56vwhAxDZLgMqLqpKf9E5YpRKJ4mE9EZc0aTRhcm
         Az8sF0DEZwTkM61/k7Dzs/Nga2Mni44OCVPVN3WkK1w087BSa8tn4n1oId6EVdwLqKC9
         a0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715990; x=1768320790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gDBwaX2tbeEhZrSwSpdBrEdEsO8lUCzTxea91t7m1AM=;
        b=vCxgVavJRuOsOr0YqFTL6fTpip18jA6J0b5a1u9g0ipPMker2vUdk4RHiwbbEnbKET
         PZd0b1TKtgewLIs74gmOLm/a3xWp+Er0X0tgEjiEzLMRLPyjrFfm9jBw/n9x8XmfU8+S
         c7I2m4MtB476CYgukZQj60J9yZde/PGtR7FmBPINCftFT34dhGv9fVjffRGMMBh0LUeD
         lQ54b3ZgBF0YwNEUAE0aKkwliTvF3kX0ghQ9Vt+kU6LqRi0KRZz27X9y9EMXq3ZxGpmi
         rmwid0F2pEcn+V+V9dL07bvrVr5BM9cQB/NokmKli/Hn8CGjWNGvg8GuetAg7SlQqSWL
         M0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuGcg9BzzNdMov6JSLkxXnkmvevUR1wU2DyPT726TiG53yX0eTvUr5y60bhnwmBpA13EYDNKp/GUF2rQub@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4fRu9GVypGQC2ClUslg9k/rW0+rWWHwtxgTQNxzuaR5354Bq
	aAgieUZUgEWp/zFiM0oi/EY4/bFPMON46A7CsQDJ2N2YgQ9QZcI7PF0t
X-Gm-Gg: AY/fxX76gnut2vP02arrHaIy2r6ouC9sHkHc40Fn111V+vwOZbZL6kPqEvMUzu9YkYm
	n5pSxkCu7EQpLZLT1ly42rT1aT8KCKsbMJSWu0ZUnLraV/fxwfen3JxrOu6KxveWKpZSrHLusLX
	JHHmJo1HmBIkXUJKJxP9k8MZeG4puv44cXY9Qxvtx7eiSkQAhMdnf2iD/lRH7N9EvgfgbYSyxrC
	qvbTVQBMRr3/WKU3DsGwGxTMNDKV1DHTUVeinYa3C6CTXNb/BuYCCtE8bcgNctK6JLteJWU8Yif
	PzHoOhlqaHZ2Qu/KyIx0SbikY/d1ooIhfmSqS/BpZLPGLx7J/V+LsSlEFilVhyhld7fMPzk9BDU
	gzeHRgEXVdXkufP55R3NFXZFoN3VEYXub4Vxjar7zv6p54vZoJiktPrrpr2cYFJ2UNmmMkxdOco
	PiWIs2OM2qdKAXxk5+2YWsY1u55ZDkqljVUsEdMd74PMZJrwM1aDOwFewhljZoG/bTLrPq2W2Uc
	QBtCw==
X-Google-Smtp-Source: AGHT+IGRuC9x0JKm120kgdj5Px6SiSPfgvsaiYELSkLjYGdy8H5Bizj14zDJzMyXimu7DD0V6rf86A==
X-Received: by 2002:a05:651c:50c:b0:37b:9615:e43a with SMTP id 38308e7fff4ca-382ea9f2dc6mr8741011fa.1.1767715989652;
        Tue, 06 Jan 2026 08:13:09 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:09 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:40 +0200
Subject: [PATCH RFC v2 02/11] rust: add new ThisModule trait and
 THIS_MODULE impl
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-this_module_fix-v2-2-842ac026f00b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=15432;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=/Ms0ilmTmhT/+pTanvifPfpMypKbgHczZgI+jrgEiCU=;
 b=VCF39GJJp1wwxCEZh6OVLtm+AKyLVcUz5twsoTod+rQGN3fE6N85Tcj4afu8q8Y/2rGR/8HwV
 0VezZT6Bh+wDLrPTUcVyEVHc5BuWrNRBOZXrfGgU63KHQwTWcnHrQgz
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

To make clear separation between module crates and kernel crate we
introduce ThisModule trait which is meant to be used by kernel space.
THIS_MODULE is meant to be used by modules. So kernel create will be
unable to even accidentally use THIS_MODULE.

As ThisModule is trait we can pass that around in const context. This is
needed so that we can read ownership information in const context when
we create example file_operations structs for modules.

New ThisModule will also eventually replace kernel::ModuleMetadata trait
and for this reason it also have NAME field.

To make transition smooth use mod this_module so we can have two
ThisModule same time. Also some functionality is added to THIS_MODULE
temporarily so that we do not have to change everything at once.

Also examples will need THIS_MODULE so also define that in docs.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/block/rnull/configfs.rs |   2 +-
 rust/kernel/configfs.rs         |  46 ++++++------
 rust/kernel/lib.rs              | 159 ++++++++++++++++++++++++++++++++++++++++
 rust/macros/module.rs           |  16 +---
 scripts/rustdoc_test_gen.rs     |   2 +
 5 files changed, 188 insertions(+), 37 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 2f5a7da03af5..7223ee7c3032 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use super::{NullBlkDevice, THIS_MODULE};
+use super::NullBlkDevice;
 use kernel::{
     block::mq::gen_disk::{GenDisk, GenDiskBuilder},
     c_str,
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 466fb7f40762..908cb98d404f 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -110,16 +110,21 @@
 //! [C documentation]: srctree/Documentation/filesystems/configfs.rst
 //! [`rust_configfs.rs`]: srctree/samples/rust/rust_configfs.rs
 
-use crate::alloc::flags;
-use crate::container_of;
-use crate::page::PAGE_SIZE;
-use crate::prelude::*;
-use crate::str::CString;
-use crate::sync::Arc;
-use crate::sync::ArcBorrow;
-use crate::types::Opaque;
-use core::cell::UnsafeCell;
-use core::marker::PhantomData;
+use crate::{
+    alloc::flags,
+    container_of,
+    page::PAGE_SIZE,
+    prelude::*,
+    str::CString,
+    sync::Arc,
+    sync::ArcBorrow,
+    this_module::ThisModule,
+    types::Opaque, //
+};
+use core::{
+    cell::UnsafeCell,
+    marker::PhantomData, //
+};
 
 /// A configfs subsystem.
 ///
@@ -744,8 +749,7 @@ macro_rules! impl_item_type {
     ($tpe:ty) => {
         impl<Data> ItemType<$tpe, Data> {
             #[doc(hidden)]
-            pub const fn new_with_child_ctor<const N: usize, Child>(
-                owner: &'static ThisModule,
+            pub const fn new_with_child_ctor<const N: usize, Child, TM: ThisModule>(
                 attributes: &'static AttributeList<N, Data>,
             ) -> Self
             where
@@ -754,7 +758,7 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
             {
                 Self {
                     item_type: Opaque::new(bindings::config_item_type {
-                        ct_owner: owner.as_ptr(),
+                        ct_owner: TM::OWNER.as_ptr(),
                         ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr().cast_mut(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
@@ -765,13 +769,12 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
             }
 
             #[doc(hidden)]
-            pub const fn new<const N: usize>(
-                owner: &'static ThisModule,
+            pub const fn new<const N: usize, TM: ThisModule>(
                 attributes: &'static AttributeList<N, Data>,
             ) -> Self {
                 Self {
                     item_type: Opaque::new(bindings::config_item_type {
-                        ct_owner: owner.as_ptr(),
+                        ct_owner: TM::OWNER.as_ptr(),
                         ct_group_ops: core::ptr::null_mut(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
@@ -875,8 +878,7 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
 ///         = kernel::configfs::ItemType::<
 ///                 configfs::Subsystem<Configuration>,
 ///                 Configuration
-///                 >::new_with_child_ctor::<N,Child>(
-///             &THIS_MODULE,
+///                 >::new_with_child_ctor::<N, Child, crate::THIS_MODULE>(
 ///             &CONFIGURATION_ATTRS
 ///         );
 ///
@@ -1019,8 +1021,8 @@ macro_rules! configfs_attrs {
                     const [<$no_child:upper>]: bool = true;
 
                     static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
-                        $crate::configfs::ItemType::<$container, $data>::new::<N>(
-                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                        $crate::configfs::ItemType::<$container, $data>::new::<N, crate::THIS_MODULE>(
+                            &[<$ data:upper _ATTRS >]
                         );
                 )?
 
@@ -1028,8 +1030,8 @@ macro_rules! configfs_attrs {
                     static [< $data:upper _TPE >]:
                         $crate::configfs::ItemType<$container, $data>  =
                             $crate::configfs::ItemType::<$container, $data>::
-                            new_with_child_ctor::<N, $child>(
-                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                            new_with_child_ctor::<N, $child, crate::THIS_MODULE>(
+                                &[<$ data:upper _ATTRS >]
                             );
                 )?
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 510d4bfc7c2b..2ccd75f68f03 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -233,6 +233,165 @@ pub const fn as_ptr(&self) -> *mut bindings::module {
     }
 }
 
+pub mod this_module {
+    //! Access to the module identity and ownership information.
+    //!
+    //! This module provides the Rust equivalent of the kernel’s `THIS_MODULE`
+    //! symbol from the [C API](srctree/include/linux/init.h).
+    //!
+    //! # For driver creators
+    //!
+    //! If you see ThisModule you need to pass THIS_NODULE for it so it can
+    //! track module ownership.
+    //!
+    //! Each Rust module defines its own `THIS_MODULE` using the
+    //! [`create_this_module`] macro. The generated `THIS_MODULE` identifies the
+    //! owning kernel module and expose some metadata about it.
+    //!
+    //! # For abstraction creators
+    //!
+    //! Many times C-apis expect a `struct module *` pointer so they can
+    //! increase the module reference count. This is because module could be
+    //! unloaded while example file operations are in progress. Many times
+    //! structs which needs owner fields should also be const. For this reason
+    //! ThisModule is usually passes as a type parameter `TM` to abstractions
+    //! which need to know the module owner. In vtables ThisModule is usually
+    //! used as name.
+    //!
+    //! ## Example
+    //!
+    //! ```
+    //! # use kernel::{bindings, this_module::ThisModule};
+    //! # use core::marker::PhantomData;
+    //!
+    //! // Example function signature which needs ThisModule.
+    //! pub fn create_device<TM: ThisModule>() {}
+    //!
+    //! // Example of a vtable which uses ThisModule.
+    //! #[vtable]
+    //! pub trait MyStruct {
+    //!     type ThisModule: ThisModule;
+    //! }
+    //!
+    //! pub(crate) struct MyStructVTable<T: MyStruct>(PhantomData<T>);
+    //!
+    //! impl<T: MyStruct> MyStructVTable<T> {
+    //!     const FOPS: bindings::file_operations = bindings::file_operations {
+    //!         owner: T::ThisModule::OWNER.as_ptr(),
+    //!         ..pin_init::zeroed()
+    //!     };
+    //! }
+    //! ```
+
+    /// See [`this_module`]
+    pub trait ThisModule {
+        /// Wrapper around the owning `struct module` pointer.
+        ///
+        /// This is null for built-in code and non-null for loadable modules.
+        const OWNER: ModuleWrapper;
+        /// Name of the module.
+        const NAME: &'static kernel::str::CStr;
+    }
+
+    /// Wrapper around a pointer to `struct module`.
+    ///
+    /// This type exists as a workaround for the lack of `const fn` methods in
+    /// traits. It allows the module pointer to be stored as an associated
+    /// constant while still providing a `const` accessor.
+    pub struct ModuleWrapper {
+        ptr: *mut bindings::module,
+    }
+
+    impl ModuleWrapper {
+        /// Get the raw pointer to the underlying `struct module`.
+        ///
+        /// TODO: Should be only available for kernel create.
+        pub const fn as_ptr(&self) -> *mut bindings::module {
+            self.ptr
+        }
+
+        /// Only meant to be used from [`create_this_module`].
+        ///
+        /// # Safety
+        ///
+        /// - Only modules are allowed to create non null `ModuleWrapper`s.
+        /// - The non null pointer must point to a valid `struct module`
+        ///   provided by the kernel.
+        #[doc(hidden)]
+        pub const unsafe fn from_ptr(ptr: *mut bindings::module) -> Self {
+            ModuleWrapper { ptr }
+        }
+    }
+
+    /// Creates the `THIS_MODULE` definition for a Rust module.
+    ///
+    /// This macro is an internal building block and is not intended to be used
+    /// directly by module authors. It is invoked by [`macros::module::module`]
+    /// and by kernel doctests.
+    ///
+    /// A macro is required so that `cfg(MODULE)` is evaluated in the context of
+    /// the consuming crate, and to prevent accidental use of THIS_MODULE from
+    /// within the kernel crate itself.
+    #[macro_export]
+    #[doc(hidden)]
+    macro_rules! create_this_module {
+        ($name:literal) => {
+            /// THIS_MODULE for module `{name}`. See [`kernel::this_module`].
+            #[allow(non_camel_case_types)]
+            pub struct THIS_MODULE;
+
+            impl ::kernel::this_module::ThisModule for THIS_MODULE {
+                #[cfg(not(MODULE))]
+                /// SAFETY: TODO
+                const OWNER: ::kernel::this_module::ModuleWrapper = unsafe {
+                    ::kernel::this_module::ModuleWrapper::from_ptr(::core::ptr::null_mut())
+                };
+
+                #[cfg(MODULE)]
+                // SAFETY:
+                // - `__this_module` is constructed by the kernel at module load time.
+                const OWNER: ::kernel::this_module::ModuleWrapper = unsafe {
+                    extern "C" {
+                        static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
+                    }
+
+                    ::kernel::this_module::ModuleWrapper::from_ptr(__this_module.get())
+                };
+
+                const NAME: &'static ::kernel::str::CStr = $crate::c_str!($name);
+            }
+
+            impl THIS_MODULE {
+                /// Returns the name of this module.
+                pub const fn name() -> &'static ::kernel::str::CStr {
+                    $crate::c_str!($name)
+                }
+
+                // TODO: Temporary to provide functionality old `THIS_MODULE` provided.
+                // SAFETY: `__this_module` is constructed by the kernel at load time and
+                // will not be freed until the module is unloaded.
+                const ThisModule: ::kernel::ThisModule = unsafe {{
+                    ::kernel::ThisModule::from_ptr(
+                        <Self as ::kernel::this_module::ThisModule>::OWNER.as_ptr()
+                    )
+                }};
+    
+                /// Gets a pointer to the underlying `struct module`.
+                // TODO: Temporary to provide functionality old `THIS_MODULE` provided.
+                pub const fn as_ptr(&self) -> *mut ::kernel::bindings::module {{
+                    Self::ThisModule.as_ptr()
+                }}
+
+                /// Gets a reference to the underlying `ThisModule`.
+                /// TODO: Temporary to provide functionality old `THIS_MODULE` provided.
+                pub const fn as_ref(&self) -> &'static ::kernel::ThisModule {{
+                    &Self::ThisModule
+                }}
+            }
+        };
+    }
+}
+
 #[cfg(not(testlib))]
 #[panic_handler]
 fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 80cb9b16f5aa..1bcd703735fe 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -371,20 +371,8 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             /// Used by the printing macros, e.g. [`info!`].
             const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
 
-            // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
-            // freed until the module is unloaded.
-            #[cfg(MODULE)]
-            static THIS_MODULE: ::kernel::ThisModule = unsafe {{
-                extern \"C\" {{
-                    static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
-                }}
+            ::kernel::create_this_module!(\"{name}\");
 
-                ::kernel::ThisModule::from_ptr(__this_module.get())
-            }};
-            #[cfg(not(MODULE))]
-            static THIS_MODULE: ::kernel::ThisModule = unsafe {{
-                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
-            }};
 
             /// The `LocalModule` type is the type of the module created by `module!`,
             /// `module_pci_driver!`, `module_platform_driver!`, etc.
@@ -502,7 +490,7 @@ mod __module_init {{
                     /// This function must only be called once.
                     unsafe fn __init() -> ::kernel::ffi::c_int {{
                         let initer =
-                            <{type_} as ::kernel::InPlaceModule>::init(&super::super::THIS_MODULE);
+                            <{type_} as ::kernel::InPlaceModule>::init(&super::super::THIS_MODULE.as_ref());
                         // SAFETY: No data race, since `__MOD` can only be accessed by this module
                         // and there only `__init` and `__exit` access it. These functions are only
                         // called once and `__exit` cannot be called before or during `__init`.
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 6fd9f5c84e2e..089e38b49cdd 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -232,6 +232,8 @@ macro_rules! assert_eq {{
 
 const __LOG_PREFIX: &[u8] = b"rust_doctests_kernel\0";
 
+::kernel::create_this_module!("rust_doctests_kernel");
+
 {rust_tests}
 "#
     )

-- 
2.43.0

