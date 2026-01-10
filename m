Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FC346FDF
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057755; cv=none; b=gF8tlqm2n3T/qE24klM90R7Vqfe/EHIfmRl7NPuekhhHHquBbw9P2LV95RO/fP3FilNrCH5zQcuIpe+DniVAtHSznwrjtj/j3q1ik97Eu45uNLHgFO96dJCkmIvK4bQQn0REQZmYqLrWB/5XSwe0oyDa8YQP5ipvUnjBKzaDpeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057755; c=relaxed/simple;
	bh=qllvw0idDXOnIB0CGwSIi/5rAB72aSN88B6VHNRb1ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ActlfiRsKhb1C1IE5hCVi2iHATTXEneUgl1Bq+rhsj+wtykyq/svqmV0umoMhtfmEfWzYfJNf6PomJcTnfkV+GykNePD5XsVNTsTb5sxgs4m5dWcDrnf6PYUG8U53L+u2HvdA67tRtQbZ911L8xK0tt2HWOmzMoxiFKKz+oBu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL/Z8wuP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL/Z8wuP"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b72a1e2f0so4690476e87.0
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057752; x=1768662552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fykazAZF3HAYQpCFJz/nzZleds7CiXZwx2GOEkEsWOA=;
        b=nL/Z8wuP5dV9cd2rzWHMj8Vl+Jw2Oq1KWSIFAnCNG4QGPxyd4bCy46qxgkJHfy1hXS
         iu8Zww88lerMDmAjbmJAhSgqJ6eyANiF5/Nie9lDIzZ76TqvvRfNOh022hlidJ8FSbwp
         bjHW1IG5ikP4rGUuKFFfsTQovqaYWrD5A2SLIRm7QNtUN4PAq1LXX3D+lfdgZVRbo2ui
         WwRvN015LkB6cn0iUQm9RJV+tLuGqU2vnX5xdhUQfbW7blKA1uMLeq01HSabjN0PNwh/
         BykeTBuSbeEvr6jBFcP8aOCzkX2FObXYatT3javxbpkyApbZ6lyJg0kYKjOhveimSea1
         gMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057752; x=1768662552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fykazAZF3HAYQpCFJz/nzZleds7CiXZwx2GOEkEsWOA=;
        b=OtbR7I7lCEYkB7FJSzrlE8RXjmLSE47rFDgtFV33f9fCJ3Gt/O+vaJSene43dIig0T
         63JwGjOQT/o11fOFocgwU3k07BWHdCHxsiYjz/BGeSy0NvKRmgs7p6xG9uCjU51/vTuF
         9qGQ1oFVfYqv5JaBjHpnjZP5CrlAeqV3OJ/neK2TauMdRWdxPmP8BaVvoMz0H2Qe80B9
         p42zTjOiyqFgFgYHT70AOZ3O0yAeDAtJqngB5+GI3fHeLfwV+eHZ/qO0d07rFyvbkA2t
         gOdH++AULYDpfmDQK60++0Qv05yLf7WVAuyzpsxEVwjQs9PlHBZAsKNJB2OwaIh+HMnU
         uoLg==
X-Forwarded-Encrypted: i=1; AJvYcCXJsntcFA0LV/LN2GvpDFYRr/oJpaq+2mfNRq/oqcorEvd5I9jUBH+mrqvm1MPCPf5SNo04b9LBZ+WtyIln@vger.kernel.org
X-Gm-Message-State: AOJu0YynM7w98vHAkT1Ec1ZTQlJ1RGw9gTHfqPjTnoVHjAK4ZTXSPMev
	0z5TOEudBLJxUMfv+SIu2RurpS7FCMDLbdh14gV/WcAPKDCjs1AsAfiX
X-Gm-Gg: AY/fxX57ZM6eLj2BkZF7CYe3ojyBw1WCjVBIe8DE2oB62tOBQv1mR+sFCnxIfkKkTvI
	YzLZEQubpsW43GvSX141BrXXf6ZkfOKDOUFt4vXkP+h68peI3mIpNaDNBJgr5A38+V5e5ohqpX5
	JYuHh+y/BSVQLlTbIgK7X2wJRwfxpqjd3JYT8VHsR4xZCWrUeGzDmWpV2fntN4MCZmCdOCvNAWa
	sfxm0/oppPgyhKX3woH+oZXP6fjsAvlaljR0ycddJmxbUZxu1TsYlMxwdrjKeoTVsP8VA35iSNG
	8cW27GEKeIpwXwIgTHq+zq7deGiIYbfnlsFqIUMlt75Ztw+HA7modyYTqlI8UBivkzM0OgLWYGP
	EUtOVCfBEP4ACA9T0PRG7Wqc1qkeoVVj365+8EtqLWhEVkcuu3ZWvIqI0sErCQkrIh/h9/eyovz
	jEKDpKwR8RuJojnoCkjtFC8WgOqiJQ0Ux7INzlba0dYuYmncQzF7PMTx2l2wgKvAyiTc5AIBAX
X-Google-Smtp-Source: AGHT+IEa9C+0IkOnrnHmgn3qNoR/RdYiVg8QdC2LkRqOYQv6fDShjbGBuOp8BKFt8hTS3edZ7zPsIA==
X-Received: by 2002:a05:6512:1109:b0:597:ddd8:cce9 with SMTP id 2adb3069b0e04-59b6f02b24amr4151383e87.25.1768057751330;
        Sat, 10 Jan 2026 07:09:11 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:10 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sat, 10 Jan 2026 17:08:00 +0200
Subject: [PATCH RFC v3 02/15] rust: add new ThisModule trait and
 THIS_MODULE impl
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260110-this_module_fix-v3-2-97a3d9c14e8b@gmail.com>
References: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
In-Reply-To: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=11964;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=qllvw0idDXOnIB0CGwSIi/5rAB72aSN88B6VHNRb1ac=;
 b=3cDQVG93FqvGZl8dIN85pb9TVrWhh87GXa5i5JbwoqpeZ+oywsG1SWiCNte6DIiDqSNB+eFmU
 Fj3hdrardI0AL1Bfn0oUlBY+78DlYj094tzdD/gZ88mnWXomTrAZ/UI
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

Also docs examples will need THIS_MODULE so also define that in docs.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/configfs.rs     |   6 +-
 rust/kernel/lib.rs          | 159 ++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/module.rs       |  16 +----
 scripts/rustdoc_test_gen.rs |   2 +
 4 files changed, 166 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 466fb7f40762..fe80439ab21f 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -876,7 +876,7 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
 ///                 configfs::Subsystem<Configuration>,
 ///                 Configuration
 ///                 >::new_with_child_ctor::<N,Child>(
-///             &THIS_MODULE,
+///             THIS_MODULE.as_ref(),
 ///             &CONFIGURATION_ATTRS
 ///         );
 ///
@@ -1020,7 +1020,7 @@ macro_rules! configfs_attrs {
 
                     static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
                         $crate::configfs::ItemType::<$container, $data>::new::<N>(
-                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                            THIS_MODULE.as_ref(), &[<$ data:upper _ATTRS >]
                         );
                 )?
 
@@ -1029,7 +1029,7 @@ macro_rules! configfs_attrs {
                         $crate::configfs::ItemType<$container, $data>  =
                             $crate::configfs::ItemType::<$container, $data>::
                             new_with_child_ctor::<N, $child>(
-                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                                THIS_MODULE.as_ref(), &[<$ data:upper _ATTRS >]
                             );
                 )?
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 510d4bfc7c2b..4b899f75e56d 100644
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

