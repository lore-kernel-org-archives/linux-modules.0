Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A42347BC4
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057757; cv=none; b=FVV7yrrXeSdZoisrfSNK15+Ug8ZxVAxs9vJAgLtvFH8LH6lhLtksJo67PdJMfcjMOkUZys3+mfRLj9Bz3gHFkA6VtQV3z4VoOsEx9NV0Yxgau22n1TZkmlx588bsIBF1Gh2lojVEAJNXRa6LvbA5hpxqbknJ1Yss1VQp2sP3z4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057757; c=relaxed/simple;
	bh=891dg5NeMMgINCtxfUx5z2GhTLzUtO+bREujFmK9Vxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WtboTbnVQXVaeYmuHB9QrnOWDzHcLdwVGblDzTnSubGOlYHZrVcYP2dJNu4yY5wyo+Fs0T6MWx3dApJTziwPae0p3PtgVdBv/7NfCDE/nvr4QCgJULnypMytDRUwogtn+2Ti2bDvKNopN+CjT/+vrcTG83+NZdWYPDH1mILNWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ns6wyTsC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns6wyTsC"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b79f700a1so2331003e87.0
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057754; x=1768662554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI0sZ7uVNTRnuO/8Ld3c5O3KKGDZMWG55LzxmtwZszI=;
        b=Ns6wyTsCKAFNVbWzJ1CxIRn0XdsOkvf17b5zSed5MgBzEiMnkcrXMA6BDndyqA6AEK
         rIdJdkVRWlrr+uTu1cSGgeKkHGLCIj7qEjch6uhDNx6c7TE/M2JwqEBUWVMEk6HNelyf
         +De+i8BprT9w7faeWuqv2MVPlgr10CskI3Ysb0jJSiBPA129fdDgpKRhKWysOc1NJ9YR
         s6nFrN96bXeWIMmZyUy7b+Zlj3wcKZ/ERZMHNkhnPRSWCeAV5Jyybq8xyRl13tL7g1aV
         dXzr/+W48k3r8QETM+e2v6OV5WgfXG0BC9v8GUfVIbgCDtGQ5xa9+/B6I0/6ofX9duB4
         HloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057754; x=1768662554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SI0sZ7uVNTRnuO/8Ld3c5O3KKGDZMWG55LzxmtwZszI=;
        b=HvvAjOYxOq+FOnm8CNYdGTo5S/3RlM//mBG3Q0awqT/9RAxJD2ztDFavzsOFIoWT4p
         6w1suiG8NPpn9yt+cNIGz2WyfaOuxqJfXUmVMm9rusAtRvhMWP4z5lJ0tkOoMSFYwCFB
         Ki9lAAFZVUUWEErglD7d8MrXcrvXK/pf3swaFnxPnFxUcLkDZmf/yESRklaV6DASL9cH
         wSQyGbzH9lqT7JVtnBuzBcOcvO6OjViV/cC59FU/mOjrlxPZMqJ+wMCyJcYU3toMXY49
         KhwrfXB+73EL+o9fzLtJs6gYO48msz/QwkL141L1pit+ibhuccAz5Z+pd7BupQpT2ufj
         0DIA==
X-Forwarded-Encrypted: i=1; AJvYcCW97dx9MwcFOAUVwj6i+rYzWkRXkapy/Hyoi2fJlBL1DW96+4BpcQZRPrDujV0havd5xwOTNLU59OJoMwHx@vger.kernel.org
X-Gm-Message-State: AOJu0YwcOZ4XTtG4JpM0MRDSmdFE4fk1iWc8JJV7DLsl42IXTmnV/rgM
	kO89X/EoJPicRb7iJmqsMISEkIoxa/GKnIovAv1S7ZCRTqev40A7hxjg
X-Gm-Gg: AY/fxX59iSHxuKEda9qQ9E+xMpcuZeQf2iMDMlzZzotvD1AMn1dCqbYzvat4QU1t852
	ACUYv3dPglgF9mSwcxBGHBhBd43o99beLoAUKE1ckLtu/2gO9AcFIYal+wJMM6Rdy5neGHcoBvy
	AiuvgPLzDSSk5zmyWh+iCkzVx9AzmhiCDPcazKK0sO0epyT/u15TJ1fIp8jYCaVUaN7s6gZXy07
	9FXJPngy/VxLOoIEGdo9NjQWxDiEiBp2pXG2VwDyx/6b6Ft383gOSfw+E6RF6VJBrNK1ox7/0r0
	mDaRyb+u966n52VcIYSk5fZ0ONoXNicQ+BHFsF/30+Deb4Wp7LWYe0p49lDHV9aZur7W2YXJ30p
	SYcCMzszy/fCZ6V7AxGMgCGLRNSuC59LX9S9yY60dh1Id4zA7vjAFmzHYrPsrNaJseMRhuj970X
	6J6mtJ9TZ6hpe7+Vw8i5x7j2/N2B22z8G76vryeSVkDYtJQRpvRSnRzNXGF44rslx43+/kuvqc
X-Google-Smtp-Source: AGHT+IF15/eRGuTu7+wp+QYULK4KR7oRPF4/q3DNB7vZeYJShFYAC050bMH9rb7Ur2PCPfBPy+O9hw==
X-Received: by 2002:a05:6512:33cb:b0:59b:73b9:1f49 with SMTP id 2adb3069b0e04-59b73b921e7mr3815567e87.26.1768057753607;
        Sat, 10 Jan 2026 07:09:13 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:13 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sat, 10 Jan 2026 17:08:01 +0200
Subject: [PATCH RFC v3 03/15] rust: miscdevice: fix use after free because
 missing .owner
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-this_module_fix-v3-3-97a3d9c14e8b@gmail.com>
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
 Kari Argillander <kari.argillander@gmail.com>, 
 Youseok Yang <ileixe@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=2370;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=891dg5NeMMgINCtxfUx5z2GhTLzUtO+bREujFmK9Vxo=;
 b=YGFU2Mudpv6wmls6LVSS+C3zLULqJaxqGgs9hMIwnNZn79Pd9ugTIDLVe52c0ThqhL7w/+wS0
 cBq/kCyOWf4B6laeNZScBjMawlstvNU/8l4e7/MRGSL/nd1oFpEZQDf
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

