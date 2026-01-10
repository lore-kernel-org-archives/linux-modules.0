Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21711346FCB
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057784; cv=none; b=BGSdlYkIVV18gNW1uBubj+1CcoW56aXD+bIDp8lKTdY7rWiCvzmPpRHEtVRAuNWuG/pQXFl9xF9CPZAlmND2MJCrBq1H6H+45jO9c4qVpJG2CMWkqclrIlL6PVupTuAOwqd5UZvHmyI3uWZuuyEDOngFBx/m3JqppjyMNifDID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057784; c=relaxed/simple;
	bh=RPwYcsbO6FvGujOyqzQn4sJnbXGyGs4NpzWn8HY+yNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnlM8BkcyzU+0Sf+SsOJmBDy3CbFqr2x9VJ2wLljYv6lNYVFfISS1CPlC93prAGKJneedwKisRn+nqb1KigbY1anOVs5UdkUZFq/n3Zfs+zL97MlcTvlmDllTDLO/W/BYfsr7CbuQjuxamtOBvAMzLoe2+XYDuugAjbzrneo/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMjyDMUP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMjyDMUP"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b8466b4a8so869948e87.1
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057780; x=1768662580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJZFqk7vh2YSe9SFh94/y7TJPpOJJYaVuu6o0W+r2E0=;
        b=iMjyDMUPSEY8Lmq3R0FAa3quZjmWCFnzj0ccxNiTn8rYW7WDyI0Zy1DMSxJqXW3bzx
         +P7cmQGSiY6AJ09TTWqJrN9NN5gsp+USi011s0g/poVghoANObGOmlrdwhioBkvc4eKe
         wgBk1NtkzuYjILvPgOuWXEKNMTsfhSd/MHRGwf3+zmmYDnDFJXiT6x+IHJAEYLdg0edC
         kj/yXGQc1l6pImih45hk/lGhJHapUXVSd7LaPVpYX0U8daR2qqpKaQpTnzD7ViL50OxR
         G71kYh5mUcCq9pIuyl3n+6ag8HtO7stfVCaR9nGRACS41OnKZamqmy27MoJ6+hWmtXvm
         pCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057780; x=1768662580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJZFqk7vh2YSe9SFh94/y7TJPpOJJYaVuu6o0W+r2E0=;
        b=m2X2BvPwe6YNXgSEe4giid8+MkqwXNG92ELxosrfP8zS+lRAOLRcuwFR3ol2nwJ6xO
         xlLGBUYRNoqLmz981vpO1LjHJLiMCESTnwFAmHJ4i19ZunTNscWEkvkyE3r56Rf2lXlV
         QsJv9sa34dyQsNt1RitOvkiwcvIURFkT6JzprTb/p/LuFprHZyeyHSFMr7k41rw2vFXy
         5ggAQDqXMIGb0sq6+Hv/X5/YLKEU9lpjO4XXlNQz3B/EC9T89lTfBicJQpnV6o/ZzG7V
         ViBQ56uHST2ZnyYb/LUpszVdLXg4/GCN2GR6hXpuPrEpJiOLGYiq0DeSV03Mz3T3xzXu
         Nw7g==
X-Forwarded-Encrypted: i=1; AJvYcCXEsC90yyFJg82CT4+ZTY0exBff7VRyG4XOl7GOqQirZd5WITIrWW3DZZ+D7nVkTHsBnBkUdudUtP2X45AF@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDFv8edIyKRv+y1n6xQquzqGHb+tlSQi6HfzlJqbWNaAOBPpv
	iQwSrdt5ouJm5l5vjGz+i3v5D7UNaiKokb3Po8KR43cA09fPsOLv5L5k
X-Gm-Gg: AY/fxX4qAnOB4x/BaZegVqj5QABvENc+wQsecrw3zS4xmNOYkjFnORCzFttOYoVqobS
	0O3VzAMCyAulwMK1Ce/6m4Mpo1cP34D1JcTqvblUMmcb5c5b+1exlzJW1T4DBRgYWV256FWlifq
	SdsbpVRZfsMgNDsAAfae5k91YXKaSynDVEepjvJMH6jwnJUmOyhG7qROGCyzHIU7guKEnLsMzD0
	q7Aaf7RxCG/Fm314bOEh/laFOCachdqyTPRsS8bM4nU/XLtynozzwPbIzK/D/Pqx7eWBZ24uvgJ
	CAkW3SBkWhq3TNEqrRC1Qx76heDP1thMUeIo+jjZyv/SpkJQgPGtdmTaxZSVg6OpV75brjwgOry
	g3BpswFWjeMusIYp5mSfKgoNHrudAbASGq3gJ7Bcd82azQ3MinF2xRM0Nd6TGc5Br3FgHxlc1cg
	uK7z4UZdUs6GSn5WXCQkVb6KH25bPVaahF0UYZmfh9vl1CS+eJmX0cmr3tZNer68YCdTyOssGR
X-Google-Smtp-Source: AGHT+IGrXaDwrVcPD7nQyKOzD7OZoH3I9M3zAJdjB+Pw3+clRX2CyUU8JcGUGqOgg81EpbJqhGCXjg==
X-Received: by 2002:a05:6512:3b92:b0:598:efe3:42d9 with SMTP id 2adb3069b0e04-59b6ef23c6cmr4461411e87.5.1768057779866;
        Sat, 10 Jan 2026 07:09:39 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:39 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sat, 10 Jan 2026 17:08:10 +0200
Subject: [PATCH RFC v3 12/15] rust: phy: make Registration::register() use
 new ThisModule
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-this_module_fix-v3-12-97a3d9c14e8b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=3371;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=RPwYcsbO6FvGujOyqzQn4sJnbXGyGs4NpzWn8HY+yNY=;
 b=eOz1FkieCkXNv0LbzaUrw6lJv8jXnr2v2Ev87tDvYXN97UoTGaEAUQ7gOBLgSrC/C9PzjTfOI
 uNR/UatFeLaAqdfhARe65M84rWjJrWC14lZyJdS7QY5ojhJUns9YC/1
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Switch `Registration::register()` to take the owning module via the
`ThisModule` abstraction instead of an explicit module parameter.

The function is now generic over `TM: ThisModule`, allowing the module
owner to be resolved at compile time through `TM::OWNER`. This unifies
the way `THIS_MODULE` is passed to Rust abstractions and avoids
threading module pointers manually through the API.

This also removes redundant parameters and prevents accidental
mismatches between the registered drivers and their owning module.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/net/phy.rs | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 3ca99db5cccf..ef9c4be4f1ad 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -6,8 +6,17 @@
 //!
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
-use crate::{device_id::RawDeviceId, error::*, prelude::*, types::Opaque};
-use core::{marker::PhantomData, ptr::addr_of_mut};
+use crate::{
+    device_id::RawDeviceId,
+    error::*,
+    prelude::*,
+    this_module::ThisModule,
+    types::Opaque, //
+};
+use core::{
+    marker::PhantomData,
+    ptr::addr_of_mut, //
+};
 
 pub mod reg;
 
@@ -648,10 +657,7 @@ unsafe impl Send for Registration {}
 
 impl Registration {
     /// Registers a PHY driver.
-    pub fn register(
-        module: &'static crate::ThisModule,
-        drivers: Pin<&'static mut [DriverVTable]>,
-    ) -> Result<Self> {
+    pub fn register<TM: ThisModule>(drivers: Pin<&'static mut [DriverVTable]>) -> Result<Self> {
         if drivers.is_empty() {
             return Err(code::EINVAL);
         }
@@ -659,7 +665,11 @@ pub fn register(
         // the `drivers` slice are initialized properly. `drivers` will not be moved.
         // So it's just an FFI call.
         to_result(unsafe {
-            bindings::phy_drivers_register(drivers[0].0.get(), drivers.len().try_into()?, module.0)
+            bindings::phy_drivers_register(
+                drivers[0].0.get(),
+                drivers.len().try_into()?,
+                TM::OWNER.as_ptr(),
+            )
         })?;
         // INVARIANT: The `drivers` slice is successfully registered to the kernel via `phy_drivers_register`.
         Ok(Registration { drivers })
@@ -889,12 +899,11 @@ struct Module {
                 [$($crate::net::phy::create_phy_driver::<$driver>()),+];
 
             impl $crate::Module for Module {
-                fn init(module: &'static $crate::ThisModule) -> Result<Self> {
+                fn init(_module: &'static $crate::ThisModule) -> Result<Self> {
                     // SAFETY: The anonymous constant guarantees that nobody else can access
                     // the `DRIVERS` static. The array is used only in the C side.
                     let drivers = unsafe { &mut DRIVERS };
-                    let mut reg = $crate::net::phy::Registration::register(
-                        module,
+                    let mut reg = $crate::net::phy::Registration::register::<crate::THIS_MODULE>(
                         ::core::pin::Pin::static_mut(drivers),
                     )?;
                     Ok(Module { _reg: reg })

-- 
2.43.0

