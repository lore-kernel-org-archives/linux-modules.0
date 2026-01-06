Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD54313558
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715998; cv=none; b=Mp8uxOyHJsfHUntd3mp/XG6OekDEIWfyzIED6gqmYyDn2AvBMuNVimKogyVuc3GnA5cBD6VObN7fKGO+vdy9CusSAXiC+NQ02CSFIJT4er/MmN5jsOnrh3A100W7Ta06hbpZVHFbXBjL1vu55JIiT0jqiTPL1co8l8q3jR94R6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715998; c=relaxed/simple;
	bh=PsulVulBYOKVhtxVFsqQzoL1KhSmhEASbJ2jTpxpE5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DObUR2hK2GiZvPZ0jb8MgdHmRka4JxeaSQFqNiSnZUHj1b48yXy55whWxqg8fHoFFaFwmBjveNOhToBr8gAACvtqndh9t1feTBaBBa+pOehIKPu62EX0XgzmgE6YUK+XQKxzZxJ+ZRFNzDhzjLWcZ2expaVsGqriWs5eWH1navA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vx/Dd30h; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx/Dd30h"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5959105629bso1143166e87.2
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767715994; x=1768320794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6p/TE1++7w8lcKdQTf98fxRYGObQ9N/7Fpqo/Gx8pUA=;
        b=Vx/Dd30hnwaEdbq6aIK9ps8AGmAxf/UPpSwLSUTf0lp9HK4KuqDiWITdNOGhsAxy5t
         DRtY8UTwWoESQ8IRS0LbzgJ5vR5qFN1vfu80XtDbCjCvKCq45qDe5tW0wiFjNvlCfjpG
         BTGMN9BQsBgeDWStL5Pmjo6jvXUw7vKzFqc+dU95t/HsMgkLqEEcyZqG5EOrDnI/WHBH
         I3gH0UjlruQaZqdOIX+XeF2eZr4LewNsPcm4Y7qsoFnUS7SC0mcRa26d7aL4NDL6FUEi
         EXmDRy9IONAz2bWD6NTqqGRDBtkGGnFdBisO8LA7wswSVhwzGuSHCDHz0UqjKn01YQiW
         fXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715994; x=1768320794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6p/TE1++7w8lcKdQTf98fxRYGObQ9N/7Fpqo/Gx8pUA=;
        b=oc9bLGKjOBqUMV4NqJgtq2Ib+qb+OEofN8yIaRJxFUymyk0hYZbv/sj2gT+gPExCQe
         uqYHuNEJsXLXRDUAYJURRteiW9Eiz1e/dNbztpXwnPb21NNuKZA9OQLQaKSYKArxw8ZD
         7L4Y5jVl5rdJGJqvsvTNKwxxLghnoFf+dHk7msOoValxsEjfPQLWXcwTGaWtanPpBAzB
         zs725d3xofF64X61bGqFXKunVXQYUsPfXI7POc/tg4d7d5OkcJ/6spGBpzkffAstlZs6
         y9UBhnerGdqIP7O2LwNVTvU703gwiYDVclgN852dlAeWYtl2bmn0a68RbGJ0SVAU8iX3
         9m4w==
X-Forwarded-Encrypted: i=1; AJvYcCUfCKaxEE0SPibftLrCDpx7xAShAo1M1BhOtomyceS7A6GYTsIRjiZPsCzTdP+V1gPcktrXOvkeHKj25FuH@vger.kernel.org
X-Gm-Message-State: AOJu0YybYhxDznKHHq2rNZzXlLzDzbRSJV8imhFD7albsk6sJokVQGea
	jFtzXtVmG+jrvb+e1JQM+dXhZiFIdu6b1nG9wRbTi4iFniWp2yMrZRE5
X-Gm-Gg: AY/fxX5qgjQPMXyJU00uGoEgw+6Al4f7KB6vgAwMLq9fOvjBvDOkgbKjXkWsdRPI7sS
	Kcabx1eToEtrgETmsnpG6+iLYrzz4iUpuuwM2bL47Uk77/+ccWZCj94loqoV0xN5LCrV75Q3mDl
	3R+4R6KhCz8YWF4Beq/3UEDVe0P9OhiNc4yGSx2tvK3+EZB2HNg9N4N/g6G3teyQdsqFFJJBbGA
	dg4K1ZUKRtTuy9P0R1umKyNLLhtNwzvDLfr+FkcKme8ns/EYmr7J/dj59VYaxnHQzHKSBPpQBVE
	b3YoNZdwTtrjMmvyJndmHN+VIol4IkGOlBeiik0ESZbygeKif5JSXomvteDmuOniIbhzji/7IaV
	BnCgpti0MvM+GBWYmTyzi18nc1O4on7WxlegaQ41zRFZjn0Sf45sqlbbiaVIpTVMF620k8VEGin
	yLxr/UuYBHsdTGJlB8vL7hrDJFBzchNsnTGT0vVE686lCYH7A97fh3MfVUYcr4h3M17L9S9NCyk
	sWtQ6CHk1SweQeD
X-Google-Smtp-Source: AGHT+IGlXyOOqsVxrzerdqZLWzRZbo1sVTEEFXJL0FcS8CHueTTVetp3Ab+FGNQAORlulzN0p9Q48g==
X-Received: by 2002:a05:6512:124a:b0:596:9c01:aeb4 with SMTP id 2adb3069b0e04-59b6528578bmr1179647e87.18.1767715993393;
        Tue, 06 Jan 2026 08:13:13 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:12 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:42 +0200
Subject: [PATCH RFC v2 04/11] rust: block: fix missing owner field in
 block_device_operations
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-this_module_fix-v2-4-842ac026f00b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=5351;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=PsulVulBYOKVhtxVFsqQzoL1KhSmhEASbJ2jTpxpE5M=;
 b=Sim91oPpd8l6p0q1O5Xp6fchcI+KFs0dqtVx/nb6eTqylSjcfpMwGbx1MCNvuwMzNycLZHSXT
 6GC7B7fd+dUDmk1/IvWKXSPc9zWnTh8NkP6D1PwidvIhL6AfTpdTZRi
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

