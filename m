Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11669337BBC
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716005; cv=none; b=fbabAHqKi+kZjKiU2Go8QxA1XUfm3Nw/fu31avVMJ2MrO14nUBeG9VoMq65ZrqmB9GA8I/V1GjvUxRQg7/aUDl7jZ2LVZHM6eQ1H/vYexHKgRaPsruRraruKR7mlprPh4WnkFJASCyaX2SP4B27QX2zZLGvyckXL9EzLvjoNmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716005; c=relaxed/simple;
	bh=cmxaklbkQRdcmvAPv3nZU1XmyGWj+C91dTrjBACqY00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E5eLNGuTM10gCZZwyqLzYeZCw3sF3eeXbxBiTjePmJtWntFxaTqC/Ux1+DFYMCDcsgGQ3JpZd8uuzMIjZVsQfhOKH/9hPcr59Q/Cb5jqj6jjbw3NOVlBnxKQ/HJPC0nRCIS4MOTnAtdFGdvV3kRXCW1hUoDSS8RR34vFBGVncNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3Hya9hy; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3Hya9hy"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b99da107cso10352561fa.1
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767716001; x=1768320801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5aCMn3FrqRU+TQVZ+VUcKX0ZHYXGPf5P30sbMEeP8s=;
        b=L3Hya9hy2X7Jd7Bx0vmN88cIUXra8moux1VmKDWbu5I4c1EeAxwiMKfN1vfF77ygQR
         hR6zlVo2NjnON5Aj/YJWuBi5vWao/A3eHbsoYLVQf8dCySlqrZMzLn9aZhg1+1PNRzqN
         U88i1fHimyQrmWwoRsTWSCwbMN+C1gmtSDg7TDjKN4r3e9nVfjwNxsZlhjr92Mp6vu4M
         KPZiZXnJYK/z6q3eo//4uw/peqC3cA+V+deoAWwGwKf7YQg4BGYmA733+aPBCUIqKBeZ
         TFA1g2PSkFS4yYRKZcpUlxtk57iPordlIHBDklvGKx66E+JYxQ1EHkQ9fzktKg+u9VQM
         zp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716001; x=1768320801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h5aCMn3FrqRU+TQVZ+VUcKX0ZHYXGPf5P30sbMEeP8s=;
        b=KKMKL9uFuw0J3get8skomBkfqxnC7PlHHjqi2Mxnp/W709A+x6vGUB0/e/bBEAIYX7
         vdhJx3PBdKLkB+1Ey+PdArDGOCY+TiDYT+phfE65+q9HXxqeOHozi0Z9DIHS/elMbnog
         hVfaex6Ydizx5tUg91wrG9dyovTu/v83Fmp8l/LyZJLwwntJ2Z7l87zBkKG2IZSsFlC4
         r7EIJ+S7ubgiIFvpph3vxMtMTBsjRj+kaXKWN5Fynr4Js/Ra5N6bgeroUZBuhcbd0/4A
         XOjkXTnoBjfLYQ8PbR1kFLn+wXGySe3gc7GwyZ87FweaYex+fSwTMX4yb+vcDbTEM3yf
         o8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUWRzyZbIsGFgLJ6uxevtm6Se79J76MaWEkOgLhINB8dtEnklSILg4P7I48+wiQ4yNSwQQhcXqu4eP25bwd@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjFOyBs6u9TtZV0BLHMBFzmCU0eMt3WIh70loQv2sWPlRZaUl
	l2M+dPo5TFJgm1sY3KZQgWiLie2lIXJ70Ew9JDVoPJ/UFqh6A46PWjop
X-Gm-Gg: AY/fxX6XEuRyYVd+EnB/3O24YX7SgLZueDEuanR9S5fEVBLJApTEHduPus8uNuY5cZv
	ppXm52n72IV6LlsDMQKOUcy+Qvqp0qSlvf6SjooBSc7s2NaOWUnFVpDq9ET4358T96nPOJlSk1e
	Zi7NWwfFgIoRPwAh8PZWxLPS1ZVYnOnwv7gOxC4hlXGDaFS9bqAAUqcuJYvgJEyy5fKuqpnXBH8
	ArILNWC76lcSZpnla1T2XLMsFgpGEt8ylFe7lF7ocvq1PAob90kJYGvNUTnh6ItXS+XcyF7OyU2
	DhKmjm6HisiIXvfzn0LXBL1VJ4fnJGvrC+41LswGS2Fd2aw3F59puxayrU2v7uAjGC8fTDiRojo
	Bz9lXlD1qNkpxyrHWOb4BO0062rzF5M+xDPXyMLg13c261muKEJuPrwXAC1tnBKlcMiarDAVo8Z
	vTGMVzWn//4FEWtv75OeiPry6s7/nrEYGvteMuJZSftxFW+Q2pl4rmNGXxS6IPvhll2hvC108Yd
	LTHqA==
X-Google-Smtp-Source: AGHT+IEtAEGIdsEnrjEv9hp9aYk8dlDx9Z9M7RXZ2NsQs+GlYYPz2YQjUEUNJFTWzDj+8iPFr+ObPg==
X-Received: by 2002:a2e:a98d:0:b0:37f:cc09:3197 with SMTP id 38308e7fff4ca-382eaabb987mr9562311fa.23.1767716000748;
        Tue, 06 Jan 2026 08:13:20 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:20 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:45 +0200
Subject: [PATCH RFC v2 07/11] rust: phy: make Registration::register() use
 new ThisModule
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-this_module_fix-v2-7-842ac026f00b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=3371;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=cmxaklbkQRdcmvAPv3nZU1XmyGWj+C91dTrjBACqY00=;
 b=klGzWdOZ5EgPSjks2EtqIzlsEOOg95lAi5QZmehg+4hxXdUW6mLP37/BYLKSPS3LauFIz4LDk
 dWJXi9qxenlAQp+keh9h30GqcEXUmEVc0MNNhASsQEK7vOIDyJbD+pz
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
index bf6272d87a7b..b6c99bf7e97b 100644
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
@@ -891,12 +901,11 @@ struct Module {
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

