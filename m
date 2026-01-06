Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AA2DA75C
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715995; cv=none; b=QB6nPNFpiXT6AsuaIEaSrwmP2K0TFhvFRJ6c7D4AKbc0BdIyX2kvLpNY8xajd48kAbl6iA+0hyjYJNSzYbteMrbUn/idZP8IBS2e4ZWg2TxHsCnnOUKVs8vSUoOebx+r4x8jXTgKvxmk0widkeMYk4DJjFTqOcGCpa60kntrOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715995; c=relaxed/simple;
	bh=891dg5NeMMgINCtxfUx5z2GhTLzUtO+bREujFmK9Vxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFTo0g97LO8n9YezhD0l7nZO3AMrfSGiObd8+y77HWNaO+Jah/KV8PqT9vvsBxZDTMMwtUWxq92+zifr+JDRQOQcstw/MPByI/J4Wr2YR3ln4Mgg882HSSBj4xzjMog0HtImcwnCFv4Gai5mViTPUF/9K5ds7Y5hW/IarEqhnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldu++Ps4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldu++Ps4"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37b9d8122fdso8851921fa.3
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767715991; x=1768320791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI0sZ7uVNTRnuO/8Ld3c5O3KKGDZMWG55LzxmtwZszI=;
        b=ldu++Ps44zc7q53vPwr67A5C/YUHDRRHIknPwGDZFvgN6MCdczym6TRGrzGiV/dPb3
         E2Tz2usQgfl431x6YYsDhbotP4eOAItpgWJIMHWym2W1yet15nTDGAChTfd2ysDv1mvG
         VQ15EZyc0zXZ6KxV4gf9I2Yj0Z1J/OFkjT+Jo2SO+2yGfCFsNhXpwAPDIiqrPJo5uiPk
         h0NwIi80fU0FcfmO7q5BtVF25MMYkb8LigHM65Uau9ziaO4yT/QJX7Mm7bqTQMpl5a2l
         rwIXIcYi9C/Wzm2LQpnBR5y5zmDQL7l9/wbb0EuY/4ormYAm5Gxk/CEjfqC8lZWMtEeD
         dHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715991; x=1768320791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SI0sZ7uVNTRnuO/8Ld3c5O3KKGDZMWG55LzxmtwZszI=;
        b=rG0zFUtIPtPF3mL/94FwYIyn23zBrkSuB9RUlUWjOTcfxtNwZjvUSOijWfydjfrBiX
         MDU2c5P5C/nT+FPa/D5gcnGjOHAjwwavM+bthFFOVGVZsSNuumnahYFw1YqUONaaCD5t
         RvarlQz280qhpxk6lc0TY/FswBA6UG1VtuqX0Op4pVIK1/zs0mSecclLexrbBbmG5KO/
         7rXHi29Hbh0Gz0s4otwge4yG9ZXXIKQOe5ZRBIV1p8o+Tz/P3VoWtJ5vsAn+ImW5TzNs
         NmOzjCXBKVUZsOaihEzkn6m4MmQlr/of33Y7e9l0S3MEBCy/x2EUJbFfDaHsNqIsfom+
         Ph1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJeM1AY85i8BKeLym9oAdo1ktKXJPffwXMmpqz0Z1nNNCOYqOEZy8Q5/KBeSvaNhtSlRiScjQ5rL3DuHAF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6/6/HV70tvki/MqYyWb3Sgc90rDOr/pcCeMnvRTwGVkE7m4U
	GvU7z7t++2StQOugem20cxWyWDcrujYJCDSu0zsbVG6r0gLqv6g0rjjA
X-Gm-Gg: AY/fxX6bOYHzz169it7UeAKdtafUw19zFSWO3KxpSsQn/3kJonHMa5mVI4W7RSyjGaa
	5Yd3gTKSh8yfLZ09AaM7bGdnIJ9S5cgsKaH2XbUROlZ29ow0LfEzeuVi+F9ghS/jFs/hPmhUB+i
	DbWYQ4gTfihZS5yaPQwICWSrKZZeVe3UYqBSIjeHaijo/d4uiuijV9m/2pPL41Wipy5R0fRKms3
	KznhwXE2JMSYP6WdC2KR2Bf4NUhZDbzneFri9AjKEP4HqhKeLncUqqqJzkHQVJ14sKhOiNOUidI
	uUEtra3oV9AuSuNxCYbguOFeE07+p4v7W5tznpSTlWqXbTeiz3zbD6DEsNpidi+FkqJVSpdr19f
	DaTq3j0ziUPhv7g445jKl8+B/eVrkWXuf6YdexzneP65Tn8x5b3FL2OD2ASCNrxq6n5xW2guJDM
	JiAduQOMczHP84AYJ2BHS6AT7OnRrJ6vEozRS5ulMIHGVAaE4jEjhp22lW8BlRdIIEbVBJUo3Bj
	lhakAeCAIbv6qeC
X-Google-Smtp-Source: AGHT+IExWVexzUnKcxTwfYgOYf3r4tTgS0aisp7MxRHoeqvXnsdWfpbBK/qR84vqvGxwAzpgZN+KnA==
X-Received: by 2002:a2e:a905:0:b0:382:5178:3e96 with SMTP id 38308e7fff4ca-382eaac9c85mr12054861fa.29.1767715991373;
        Tue, 06 Jan 2026 08:13:11 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:10 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:41 +0200
Subject: [PATCH RFC v2 03/11] rust: miscdevice: fix use after free because
 missing .owner
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-this_module_fix-v2-3-842ac026f00b@gmail.com>
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
 Youseok Yang <ileixe@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=2370;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=891dg5NeMMgINCtxfUx5z2GhTLzUtO+bREujFmK9Vxo=;
 b=XTB+sVOL63dP4+VWC+iJBYkzCmbAeMtvvB++kKg5rg1gpSNNQmkqwSCagBJoh3NsSq0qwA4nQ
 VI5WDjBJtTIDa6b1hFQyngjY104t7ooXovgREEee0nWRpTUeFWWqvFb
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Currently if miscdevice driver is compiled as module it can cause use
after free when unloading. To reproduce problem with Rust sample driver
we can do:

    tail -f /dev/rust-misc-device
    # And same time as device is open
    sudo rmmod rust_misc_device_module

This will crash system. Fix is to have .owner field filled with module
information. We pass this owner information through vtable.

Reported-by: Youseok Yang <ileixe@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1182
Fixes: f893691e7426 ("rust: miscdevice: add base miscdevice abstraction")
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/miscdevice.rs        | 5 +++++
 samples/rust/rust_misc_device.rs | 1 +
 2 files changed, 6 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index ba64c8a858f0..d4b0c35c4b60 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -18,6 +18,7 @@
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
+    this_module::ThisModule,
     types::{ForeignOwnable, Opaque},
 };
 use core::{marker::PhantomData, pin::Pin};
@@ -112,6 +113,9 @@ fn drop(self: Pin<&mut Self>) {
 /// Trait implemented by the private data of an open misc device.
 #[vtable]
 pub trait MiscDevice: Sized {
+    /// Module ownership for this device, provided via `THIS_MODULE`.
+    type ThisModule: ThisModule;
+
     /// What kind of pointer should `Self` be wrapped in.
     type Ptr: ForeignOwnable + Send + Sync;
 
@@ -388,6 +392,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     }
 
     const VTABLE: bindings::file_operations = bindings::file_operations {
+        owner: T::ThisModule::OWNER.as_ptr(),
         open: Some(Self::open),
         release: Some(Self::release),
         mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 49dd5814e1ab..464e3026e6e3 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -155,6 +155,7 @@ struct RustMiscDevice {
 
 #[vtable]
 impl MiscDevice for RustMiscDevice {
+    type ThisModule = THIS_MODULE;
     type Ptr = Pin<KBox<Self>>;
 
     fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Self>>> {

-- 
2.43.0

