Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2C33A707
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716011; cv=none; b=VzQoe6RfqS//0my2RSd4u94M7H3nLJiC+AiAqXdkwZGcaYC7zr4c9SB8/thuOY1XPjEfIeeA1WmySWm3bqwzxNWTxB6jI78tkB9LAsf5GcgTCBMBmPeA/WciM77E6aOdn9vSIiXFLXlU4UlA4N5FDKL3ncapN30jHjFsfZxLQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716011; c=relaxed/simple;
	bh=31K3z/TeTL27blPoZfDSHOqEMPWwg63C71FzL1KNDBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htXQSg876POiTGIO1ov6u1acP2nPMAcDHS2MOe9RnwxJVK7zccwHCEkMiYJAeTPo1xYJpYhqUBW8WnzUzw9SnDWQ0+y75ykDhIKIdEldwRVM63PbnOawJVkRGYaEPdTK72C7JxHn74yiNrevw2DLt082/dcEY3WoLUEhDIn2jKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js9H5iCD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js9H5iCD"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b6c89d302so288400e87.1
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767716007; x=1768320807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rzq6sT7GcMk+zrj1ACCJmSl03CZtKzXScBbEctCNtgE=;
        b=js9H5iCDT1xuYoBwfMQoX8HBM4fQF7ARMJuPtWMXdN/SRJqmJ8Am75E2rITcGr4lev
         UQvHdP7wDWL1e9hb/I05KwrWlQyoWRxVFEyQN24shW2lOTNJgavuFdAi+b9jxd7KoHwI
         drlhKUUVeWtBLXnvuJnuWGIFbMCCvYmzYhVIROeyAhClVX8diUQdEZC6iIqU06gvNCwA
         V/5xHrhFbEig4JJK9SZLTo3bv8Tqr5rHjSoTZKKDfPNAhx7AJs0qdRwGLOm4/JuQaSQi
         Fu+CQN/+YayRAjQKJxIW9RjPVf1bXvmUr0S7IrJJKqIfaE6mpbg0uUy3OTtCbvPp9Fub
         16sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716007; x=1768320807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rzq6sT7GcMk+zrj1ACCJmSl03CZtKzXScBbEctCNtgE=;
        b=o8lwGS5mmEFi9dIDE1scNWAENtM5CDe5VJm4UMp2iAF9GIg5L9x37mvFEjkgD+egFi
         xAJUBFp5a/zd9duUBx+iT56pXrBZmt20qnxe8iI57qMko9GAA5ZfiZqlpGWQO8jSJgkd
         66Q2tY7HpzxSLRG/zJ1VbEhJnjHLEGUazXj+D3O6YF1uSGXlhZ5KVXFmdhmzbeGUX1LD
         idmDws5v/hyMqCdnNcYEjSePR2B82VeiHwZGvbn4OaWqmGB3tuX/OTvX5VMQCznXdAhT
         yVfCXRA2ylSqm2ce/ww1eAS8ZvvoKq957eJ3PlyXS5UlrrIE1xm3m8OqQfV0GoKq8lGs
         B95Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwNXyOS8m1prl67cR7Pt0Nf38YegRWTCsFIuYw2zir7/HgWWXNNi/R/KdDpOYnWARDZMfWKvYVbhdvg/KD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkwt7t0utByHPX/B1wS6+e8SkrRRz9c6PGiaslIbYhD1PwnqNJ
	ftK386Qh3RTPpDs1NRnrqKPrE0kDFwCMXv6do9A/t3w8uqHTL7gpSgb5
X-Gm-Gg: AY/fxX4ZYGoyQ33POo9WgpBWTR/it0bUDdsU6Q/a/SXaWMPJ44wopsKUAnj0GupaCfW
	PeLJQkX6B160v84YhxlXhjZGi1+DwmCThYw1qjdonjBUrmxjPzxpu/7YDO1aQGul126Zht1Sviu
	g83aBQ4CbcDX0htOkmXRibDoEUIDBI7oF07PhckIeB0vuoUAwwcF9eNCq5vfFNgJu1J5/l9mVOv
	Oq0VVnx1o5BkR1kncdoWEIJ7EFION+XLfvIKF6sOv11PImHZoYfsf3CJDRas4bLcLxmATlPh9e0
	iWMWZ29Q9yVg5XzHSne5kG/R16/QuwX4ZS6Ljhwkyj/cAh1CXCzzcmPGn0g3glVF+Qbv0x7rSxq
	0cZMJTs1RSWH/WZ5D52bROAAzb23cBV9J+VmV1HFG2lr+AY04u2NZ7Ad5jwnb1Y5GC+tsmIb2GB
	TrnwyVbywleAalXixKyM9qbpzedTozFSiij9+MmA3gfyj17E5cEswwQTpzWo8BDMwFWK/H0HHgE
	cPDcw==
X-Google-Smtp-Source: AGHT+IEP/ySDqe0fUbCPgt5iLWx19W1TWyDR8oFVojZghcOpc//7QvyUeu7CEG1drmNLRunieI+/Uw==
X-Received: by 2002:a05:6512:10c5:b0:594:2f1a:6ff0 with SMTP id 2adb3069b0e04-59b6520ebe3mr1228667e87.9.1767716006851;
        Tue, 06 Jan 2026 08:13:26 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:26 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:48 +0200
Subject: [PATCH RFC v2 10/11] rust: remove kernel::ModuleMetadata
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-this_module_fix-v2-10-842ac026f00b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=3446;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=31K3z/TeTL27blPoZfDSHOqEMPWwg63C71FzL1KNDBY=;
 b=aYpSyfVvVzRtx2jZBA0uzYh2qT6PaE4SsBkyhK757T6LX63SFZ5UAGbmaYOT6qU//VGxRLdbb
 ZCWh1rldZrwA3wKCYGu9+ZCmt5Du50a7ox3x1R5Wt+7hiG44za8CUbs
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

We have all information available also in THIS_MODULE. Use that instead.
This way we do not need to do ugly casts from driver struct.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/gpu/nova-core/nova_core.rs    | 2 +-
 rust/kernel/firmware.rs               | 2 +-
 rust/kernel/lib.rs                    | 6 ------
 rust/macros/module.rs                 | 8 --------
 samples/rust/rust_driver_auxiliary.rs | 2 +-
 5 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index b98a1c03f13d..fbfbcc9446c0 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -19,7 +19,7 @@
 mod util;
 mod vbios;
 
-pub(crate) const MODULE_NAME: &kernel::str::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
+pub(crate) const MODULE_NAME: &kernel::str::CStr = THIS_MODULE::name();
 
 kernel::module_pci_driver! {
     type: driver::NovaCore,
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 11372a8f7be4..42bae71f6af1 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -206,7 +206,7 @@ macro_rules! module_firmware {
             const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
                 c""
             } else {
-                <LocalModule as $crate::ModuleMetadata>::NAME
+                crate::THIS_MODULE::name()
             };
 
             #[link_section = ".modinfo"]
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e7bc52a6ad42..dec1d05ebe7b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -201,12 +201,6 @@ fn init() -> impl pin_init::PinInit<Self, error::Error> {
     }
 }
 
-/// Metadata attached to a [`Module`] or [`InPlaceModule`].
-pub trait ModuleMetadata {
-    /// The name of the module as specified in the `module!` macro.
-    const NAME: &'static crate::str::CStr;
-}
-
 /// Equivalent to `THIS_MODULE` in the C API.
 ///
 /// C header: [`include/linux/init.h`](srctree/include/linux/init.h)
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 7473a377a3bd..97635aed1598 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -374,14 +374,6 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             ::kernel::create_this_module!(\"{name}\");
 
 
-            /// The `LocalModule` type is the type of the module created by `module!`,
-            /// `module_pci_driver!`, `module_platform_driver!`, etc.
-            type LocalModule = {type_};
-
-            impl ::kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static ::kernel::str::CStr = c\"{name}\";
-            }}
-
             // Double nested modules, since then nobody can access the public items inside.
             mod __module_init {{
                 mod __module_init {{
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 7b729687811d..528866b953aa 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -18,7 +18,7 @@
 use core::any::TypeId;
 use pin_init::PinInit;
 
-const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
+const MODULE_NAME: &CStr = THIS_MODULE::name();
 const AUXILIARY_NAME: &CStr = c"auxiliary";
 
 struct AuxiliaryDriver;

-- 
2.43.0

