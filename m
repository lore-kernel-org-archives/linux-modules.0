Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B13491D0
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057771; cv=none; b=sNZcqOlDZoBPfnkX6s7jGz7JBgHo22fPiP+RXuS3TA6EQ6sMdiHkWjDlsMSVZSgJxtm4gaFDomvslxWjUksssx7t0mH/H1OqOJe0Nt2BnOKtA0GL1wc6MlRN1sDsBF7WRCfMAxEgypUyd8a4jon+8D/s/RxNBt712S2TW+VGbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057771; c=relaxed/simple;
	bh=1FB+uT1pALfUGFef4CiqxjN0XjuunSUgAxAx5cQ/hwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SySiChZBWP2smP4wfQWtZ5rLOel40iUt8szVBXCM2UOWaOjuSuJ3TGrfnYq2rv3D9+k1ILwT3lpofC1tCHvIjwY/ifQtYUmwx717ttI/O5EFmxXKxl+AbGjmlTHsfocmbjbhf2VkIXtRWOVUF7wdm+0n/eqRO99BG2g8r9KwOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKMMlPNv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKMMlPNv"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b72a1e2f0so4690571e87.0
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057762; x=1768662562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vqf7LCg+sg6Hx5J5qs/p3xtmlckbxwDqMrE5j+qRjSY=;
        b=CKMMlPNvXpMm1GvHDNAatxWV55AUHOZ/PGrn124XPDPrWuSgUdhRqbmUHGlZ82BJht
         nDTSTcpsiNo844EQgZ3vRE3LIbgC2L/2tCwAtw57a3RBAnCAc2tBunEZLSzTXwO5hQkt
         Z6vfxBO1KrdwOGWMk6hMWGHp8ITA2UxQYbDFMEIXcT7HorZ26Y+U1wUNBI6rCV+MhRN7
         6Qm5OtL+PKlAL5O0Rg5NGEdDiGmuEuq1/VCWt+EHHMOm/h44SEkzvDM36OYNJFCPt0e8
         6umbr6gRTqplzwwdwSbSJP1AGItO/gbdTOcIr0y3MJztwvAHEDHcJhdPsODc4nqFxxog
         6WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057762; x=1768662562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vqf7LCg+sg6Hx5J5qs/p3xtmlckbxwDqMrE5j+qRjSY=;
        b=QNKXnrVABJg9HM6ClIKxdq2U7fvZahHvIeTlMOST3CpkKCWOD0QX+vUvDqhszPVvCF
         lB7duZsKIe6GVQwWhIRXUM9Q3uyAssY2t0Ymn0umtCuI9LiDiUE2e+Q7d+tiPd9UOlMp
         HqxifVY2l8I1bJinZL7NtLZCk+5PNA04/Uz8CNai2c3/CEjywLEz/mg0UwwJi3bIVUEB
         c03kSiJAykB7A1mzHZXVMgFxcEqgDFvnXaD9RBaDXZmmWufTBZ4m/U8XBTJk8bMzVTj/
         TItf8J80EMJHSYyP7J0wNe+z7BsMEZSYJsmoj3oso/uEBiVf/Gh/JJFElkGa9OiNJzrF
         9DcA==
X-Forwarded-Encrypted: i=1; AJvYcCVJuqiNHdEg/iGsv8dQ+qMkvWttuecTo4G8geZhq1PkBnJ57OqUssI2NzfZkguLnPpytgxcVTaLh23qTDJ5@vger.kernel.org
X-Gm-Message-State: AOJu0YylGkRvAFx5f0QahW+kkE9BFhrmEjbGrYTpzXoRcoeg4BBbkfoV
	zxVRkPsZzno/oDKBDEVhC1uP+H0l7jbRPulPb0EvEIXGqEfc87bn+8ebH94IGlwk
X-Gm-Gg: AY/fxX5eKhizwgQCTGXK0KzwBpkpZ5sS6FnpRkOjHKwFckmLqE++VE1339LN6rrYijA
	y6WXGXFBxman9IfcYZs8s7mMyMIndwY2ujW3KFCivJft+PR0ezYdUooA7YvtoPbKZtfLKMqhqFr
	NTsnybH0F7X1d1S7KKYGqjU0S4y+ZWrZ1hYjNrcYgOnbXITIFD7ln6oOuL5pICe1M9pxjOLKeYA
	cX2ekYGiZ8laceb4E5R/8gldlvBmjweISGCnEeiLJJoiPos3LVAM80nuJBRRzLwIFXNLMcmb+3y
	E1O5ch8hJbfXGgOm2CtyFDxHv1Zt+BKIk3rMsa7yp1bEZQ3DhpcdyDQWoOwzb9W9J6FHE8povXN
	Tj0csist5uougYSel+EzuyE1nI/otqYaeT3EkELlwlAnh2aF8LLXgAAmT5klV9JladsP3FlGnXz
	q2GRSRzdsRNkGT1bKxFWgowVLDYjPNw9EHJvTb87WX5Zw0a9ANWHfaYxbzx43rou07toe5ZUIS
X-Google-Smtp-Source: AGHT+IHEE1TGipeoD2/6eyBBIsojGiNqm7JwcbPiYjVFBwHDR5nwSai8es4nGi6I/fgjxe+bGdX/zQ==
X-Received: by 2002:a05:6512:b01:b0:59b:8483:8d97 with SMTP id 2adb3069b0e04-59b84838e5amr1204577e87.13.1768057761899;
        Sat, 10 Jan 2026 07:09:21 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:21 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sat, 10 Jan 2026 17:08:04 +0200
Subject: [PATCH RFC v3 06/15] rust: configfs: use new THIS_MODULE
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-this_module_fix-v3-6-97a3d9c14e8b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=5277;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=1FB+uT1pALfUGFef4CiqxjN0XjuunSUgAxAx5cQ/hwo=;
 b=KTu6JmsvpKxaB1JzW8EXhr264WUGMX9sqMRbv98Urte4QvFUB+KimYWM6CyVbNCSLfejIngg3
 769ilDyNnBwDbNGyi+QKw7almLRAojJtFeFDvsqYuTex4HO29lmm4rN
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

We have new THIS_MODULE and ThisModule is now trait. Pass THIS_MODULE as
generic type parameter which is current convention.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/block/rnull/configfs.rs |  2 +-
 rust/kernel/configfs.rs         | 46 +++++++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 23 deletions(-)

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
index fe80439ab21f..908cb98d404f 100644
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
-///             THIS_MODULE.as_ref(),
+///                 >::new_with_child_ctor::<N, Child, crate::THIS_MODULE>(
 ///             &CONFIGURATION_ATTRS
 ///         );
 ///
@@ -1019,8 +1021,8 @@ macro_rules! configfs_attrs {
                     const [<$no_child:upper>]: bool = true;
 
                     static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
-                        $crate::configfs::ItemType::<$container, $data>::new::<N>(
-                            THIS_MODULE.as_ref(), &[<$ data:upper _ATTRS >]
+                        $crate::configfs::ItemType::<$container, $data>::new::<N, crate::THIS_MODULE>(
+                            &[<$ data:upper _ATTRS >]
                         );
                 )?
 
@@ -1028,8 +1030,8 @@ macro_rules! configfs_attrs {
                     static [< $data:upper _TPE >]:
                         $crate::configfs::ItemType<$container, $data>  =
                             $crate::configfs::ItemType::<$container, $data>::
-                            new_with_child_ctor::<N, $child>(
-                                THIS_MODULE.as_ref(), &[<$ data:upper _ATTRS >]
+                            new_with_child_ctor::<N, $child, crate::THIS_MODULE>(
+                                &[<$ data:upper _ATTRS >]
                             );
                 )?
 

-- 
2.43.0

