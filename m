Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02276347FE2
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057759; cv=none; b=XozSxgE4618QQ79OTCKBdRMi/XiOg0AOafFXWMAML49rz8r65qM0HtsiE77knSB0XrGsoJ/n0wyHhBlAlgyukSsczGptldJyb6K5fES9qsXMtSlfpINmi3iY3recnK5qLUVPMB8JQ063zTdh07Un1V6ppZ0cN+rPidGFEHQZ9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057759; c=relaxed/simple;
	bh=PsulVulBYOKVhtxVFsqQzoL1KhSmhEASbJ2jTpxpE5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jC66458bzfuqnG9cp0SmgD3ZKDDjTiPAIUGzSIEGsrb64l9nVVxkdJ9/+pM69gGMBvEf2RT724tl4mzki5vgp2qYnyJZavfX5/ETtd6DmLjbeERAc/wG2PoE3Lx1vkKCOTsx/dXXuYRVzpEFKNpAcMT25mRgvstAyC9wPV7tnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNB/2O5V; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNB/2O5V"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b834e3d64so1533010e87.2
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057756; x=1768662556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6p/TE1++7w8lcKdQTf98fxRYGObQ9N/7Fpqo/Gx8pUA=;
        b=fNB/2O5VPaQcMjJhRn9ooDDxdhrbWQ2tJueaNuRkADCw0wUBB32pLXyEQqVjC2OmBy
         gzD7nMLV3fR+6bNWtPDHocO07nop4UPL1OcOuAaI5F/Pt9ELjrqIOiLkk13KG9OpkQgM
         ffkCuCnpwLItPzPMwJVkjhEKhDcKRmrd5CZ2E0cIxcdJzhV9pAAsN7p7Ub/VIOmCYAVz
         Z9975GGB87swDXv4A3Jf/7Iw7ouO8zz/8Hk8NtTQuyqtIpW9Fct4VQOm1eaDklBLD4Ti
         mnlLWzJF3mj8yBFfximGdQjt/s/MD2wWnHiHO4GIUyE4krgcIkp/MLSUqRR5lL9AfNkk
         GQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057756; x=1768662556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6p/TE1++7w8lcKdQTf98fxRYGObQ9N/7Fpqo/Gx8pUA=;
        b=cBKITXAhWKT3VKIyA1G7jZ+WPT9TWnyfL12zbN93i7SiaR1nx06HwvSEaQYy3SRdF/
         puTwP1X0WWqF8WpC465ualXNcZ28Aqiw9vWiBPCvQW0Kp6fmRZt6+t6ZloWeioqnR4KB
         1Ff74X72w604KBymOhyMMy/aaNIwNevWzDIljFx3w1fC0m0a780wMq61GTDx0EOYpumd
         gh8CeI7jlnFYwBJCwgTfhRT2l6asgpIAssjael2Wik7KRh1VEVilTCZopJTGT7JMvcl9
         U27KeeaxQnXmEb9GQYwc6HTZytV10AxybWr5qeI7DYrhifWO2y+2jDqzeX6TYGTrQfRf
         XyDg==
X-Forwarded-Encrypted: i=1; AJvYcCW1WqFQDkIyws5Dvt5NDUOt1HCNx/1iKhYzU0YgIn6pUhR5cI0YpC0D4Zhz0PVSKLeMosPXAAbycZt1MHpt@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdoQbqcqEqFzCy/ayODHAPlyzD3FqfQwWpQUshkXnV7SJr3VM
	YY1/Sm1YsTEu9WAsNYzv5lquQDmwtD7nE4zh9bQY17z2V2JkoJugihKZ
X-Gm-Gg: AY/fxX597U4zStn1a+9aMrdM594hif8BW2ZnSdUmbIeoj2WDnsjlibfH3ZnYieMb8eP
	5pG7wXWVN41d8Ac4RxKOfDQutIauR5/ZxfhAIDQuMISSw7rdUlfDeKheJI5a1M4twbu1EmmWtHI
	qCyyjLlUkHgWi4xqgk7c1CUm2wPz8PIv7+/SGZR1Ro3+DH+khUQ/5NAYv1a1fMRTUtQOPCMTWdt
	NP2sTgiSFc2W1DTniuasmkolJyqL+Psdqad+nONam1OFdC5tT4pfElT25pR2Zf8iGe7XvRk4el0
	C8DEu3J7zJi5nzCAUOSOn+AECfRRRhdT4BYj8M27sFEPkWQVAEh+D5ayoDZYOXV3fE7tTaHdu0Q
	itOitSdJJBha2G9oGtggT46MXV1QMFnFMNmv09qaYtyNGo1Wk+2jXw1CRJGxxcHtV5bUMMbzMvM
	zcsE52bAYQrC4feZXgHVU249nSSBmbLRvKnJ31jCC/nElQihDV2paLfOtbNNzwe3n0fjNFz7Zf
X-Google-Smtp-Source: AGHT+IGlt9Yv8sDeB4e3Q5NwnV4p5lgaXKn9ea9qedHkfBs0ps8vJj79GZDi9RawkBZhq22ruSs+oA==
X-Received: by 2002:ac2:4e0c:0:b0:59b:7b86:44d2 with SMTP id 2adb3069b0e04-59b7b864515mr2191519e87.18.1768057755950;
        Sat, 10 Jan 2026 07:09:15 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:15 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sat, 10 Jan 2026 17:08:02 +0200
Subject: [PATCH RFC v3 04/15] rust: block: fix missing owner field in
 block_device_operations
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-this_module_fix-v3-4-97a3d9c14e8b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=5351;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=PsulVulBYOKVhtxVFsqQzoL1KhSmhEASbJ2jTpxpE5M=;
 b=185gZsCt1xGiCyXyEzSPP0pAcZ1ipKyoiLBT3qAgSvAHQ5mewac9KEA/SJgWHYzP0ShVf4l15
 sTw9hTUbbf/Bpj28SG+0E0IafHVZBRm1xGY6ElfQmn7afXlsCIbrPqv
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Kernel has now enabled "const_refs_to_static" feature. We can fix TODO
item now. Fix this by defining owner in vtable so we can read it from
there.  As this table needs to be const we need to define it in
operations so we do not need pass THIS_MODULE alongside with
GenDiskBuilder::build().

This will probably fix some use after free.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/block/rnull/rnull.rs       |  1 +
 rust/kernel/block/mq.rs            |  1 +
 rust/kernel/block/mq/gen_disk.rs   | 30 ++++--------------------------
 rust/kernel/block/mq/operations.rs | 30 ++++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index a9d5e575a2c4..862369ab9b5c 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -74,6 +74,7 @@ struct QueueData {
 
 #[vtable]
 impl Operations for NullBlkDevice {
+    type ThisModule = THIS_MODULE;
     type QueueData = KBox<QueueData>;
 
     #[inline(always)]
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 1fd0d54dd549..0c8e9e316952 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -68,6 +68,7 @@
 //!
 //! #[vtable]
 //! impl Operations for MyBlkDevice {
+//!     type ThisModule = THIS_MODULE;
 //!     type QueueData = ();
 //!
 //!     fn queue_rq(_queue_data: (), rq: ARef<Request<Self>>, _is_last: bool) -> Result {
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 1ce815c8cdab..4d5d378577ec 100644
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
@@ -126,32 +126,10 @@ pub fn build<T: Operations>(
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
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
-        unsafe { (*gendisk).fops = &TABLE };
+        unsafe {
+            (*gendisk).fops = OperationsVTable::<T>::build_block_device_operations();
+        }
 
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 8ad46129a52c..0f8f616590fb 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -10,6 +10,7 @@
     error::{from_result, Result},
     prelude::*,
     sync::{aref::ARef, Refcount},
+    this_module::ThisModule,
     types::ForeignOwnable,
 };
 use core::marker::PhantomData;
@@ -28,6 +29,9 @@
 /// [module level documentation]: kernel::block::mq
 #[macros::vtable]
 pub trait Operations: Sized {
+    /// Module ownership for this device, provided via `THIS_MODULE`.
+    type ThisModule: ThisModule;
+
     /// Data associated with the `struct request_queue` that is allocated for
     /// the `GenDisk` associated with this `Operations` implementation.
     type QueueData: ForeignOwnable;
@@ -280,7 +284,33 @@ impl<T: Operations> OperationsVTable<T> {
         show_rq: None,
     };
 
+    const BLOCK_OPS: bindings::block_device_operations = bindings::block_device_operations {
+        submit_bio: None,
+        open: None,
+        release: None,
+        ioctl: None,
+        compat_ioctl: None,
+        check_events: None,
+        unlock_native_capacity: None,
+        getgeo: None,
+        set_read_only: None,
+        swap_slot_free_notify: None,
+        report_zones: None,
+        devnode: None,
+        alternative_gpt_sector: None,
+        get_unique_id: None,
+        owner: T::ThisModule::OWNER.as_ptr(),
+        pr_ops: core::ptr::null_mut(),
+        free_disk: None,
+        poll_bio: None,
+    };
+
     pub(crate) const fn build() -> &'static bindings::blk_mq_ops {
         &Self::VTABLE
     }
+
+    pub(crate) const fn build_block_device_operations() -> &'static bindings::block_device_operations
+    {
+        &Self::BLOCK_OPS
+    }
 }

-- 
2.43.0

