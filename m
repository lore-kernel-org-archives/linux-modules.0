Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436E3376A2
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716013; cv=none; b=WdBR5ERuGTszxsMIFS7SWF/j4IO2umMGE1Yx632ekx2L7kjpHzUW4CrSuyo1v+wREjeFtZe23eozmgyU9Z4tTvGP+sQAXGudLlTeQw+ZpZ0/4ZsxV0KxNOesi8ixoyyduq306LZJFfmYYvaDxsuWKM08eaNmE6mcigJCRUn3T5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716013; c=relaxed/simple;
	bh=DmmtaDAQNblc8YsS6wVHtlUqz9NIYJ5OZn7ml6apuUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILpQFkfK7k+NGc7nIE00OisHv0R3HN4kzcr28JHZfRbT1UJoYn7EARM+yirxfJGZYvQYyOG1oTFHhQ99iAAm80LyJssHhFCrSQcRNEKlNhqQAo9Sc/B3zyzJHfwxAbnsy9QGyv9r9X8DIlZQ8IiDlkml9dH4NM7mtp8ofvePUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USf8ptYU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USf8ptYU"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-382fe06aa94so22401fa.0
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767716009; x=1768320809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yD1KNN5/TWj3t1cQe+Jpa13onMvM2XzOEo1ubv8aag4=;
        b=USf8ptYUDxHpzCm9+DVHO4RWuMzUZTZawfX40J9OI6HOS90AATEmtGxwaSy3YcnXbM
         5hHFZU+I57W8wLiA9LrkBhL3R2ENebO0tyv4ncFJ22QgNMDN4kCNM1iwb5bAPaWgmcHk
         qclIkVvBi9wlUE027PBeaEvKzP5yjQhjP3wdgZ/pcJXIaJP+66emkYmLHPoIyRocp16H
         VK1s/MC31CYC50vULt1/yjivjBWDNeGATarBS8VTMcW9vL640XNngSKzmyn5KImxjiRV
         EC6szmQXC3scWBye4f2Vt4/T3a83jq6Kg3Weg3lDmx19hu5OkKFPiyvVe7/7+6+Ru8Kc
         rWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716009; x=1768320809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yD1KNN5/TWj3t1cQe+Jpa13onMvM2XzOEo1ubv8aag4=;
        b=rsuQkHc3EIa8G1VRQPHWdYJ+WVZEQUBz8Ze+8UzT8BhJki3V1uTjQxLWs0ZSskK/HV
         vObPNQnoURpguR923rSf3uhxWLMvaxpwpe+zRmi59vTmN42+e/Nh3SQd6/EIpEgFFZCl
         3ERNzR7kmfdilAHs9/J8juAvoSOWKsb/bNffDVdT98xscUDJFBoxBRsKYKyx9vf9zztC
         G8F3eaQ3hvGZmNDBmegBuPEVlVD5jki0gQGmc15rnTgWs0EQL8PFRBwAZHLbMmUfHzCn
         70vYkr4BLHQXZDD6Ja7/zLKipS2whXdlZhi5CKxmqGoi8Nlq99dSSPwQot2zRLDkxLh0
         l85w==
X-Forwarded-Encrypted: i=1; AJvYcCVtNmKpaTrmPRjOei0jJAiJJfcIEyrMH/KkUJdOUuCPymi9WUNzMuW8eqRITmKptGOGA0I0ep8JvSEveueK@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYdyrxNvags+nHfVs9YzgpYBxtiPpYaDpFjtp6mRwrquFh+Dr
	5VVeo6DdMjJy2Hu7N3RGny+oNYFSpL6r9urfp3Hwixb+NBgL1QHZ/myj
X-Gm-Gg: AY/fxX5iV9+mwVTGg0+v+z58YNs7C/1kDK++P5qHy5jfO7wJ3JlG2JsItOMszXd6TJJ
	nIIE+aCkhik19BiJihY652P4/0zFayu/mOFAfdpTYr1knj8/Wm9D/BkN4adKTRfppj6sL/OZBB2
	4WEuLNuRqMvD4nShj/gfisv3TDGixQ/ouTtrofdQcs7qO4BJ6mwJI42cNQbGJ4eL+tyL2BcBoIG
	5HEKeqYub3+9VUDNrNcGkKz0iyEPdnyvyzanPz14iftgApMfbEI6yDfvp3i6zVVPpjNrEmodpPX
	24iMFHZMVCH9y84ljSYuyUQD6r6Zoi78QSBcRw6eGCmBQqmlpr8zQPde1G5OraUFRwuFQyxzGVO
	9VY+s6fXXRdrK9skN39MUGMVHROMAR40Nu8B05bfgaVZEOm0E/wPZvyj5DhYj8JC+UDdOLEuo2E
	Nbmfcq71oGF0i4dAtXSxPHnCyYvx0US51QaN47oS8NMgvCEDhRQJ8EWXqKUIZj8mudGuYCL/ERA
	5rQug==
X-Google-Smtp-Source: AGHT+IGJWfLGBy47BJ7PbhNF+N9zhPP31NLcPDf0py/c4ZK/NKQFnYsEpUrBObyH1jqbw52Z4Ikz8A==
X-Received: by 2002:a2e:a988:0:b0:381:ca5:e893 with SMTP id 38308e7fff4ca-382eaace214mr11548671fa.29.1767716009250;
        Tue, 06 Jan 2026 08:13:29 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:28 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:49 +0200
Subject: [PATCH RFC v2 11/11] rust: remove old version of ThisModule
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-this_module_fix-v2-11-842ac026f00b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=3442;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=DmmtaDAQNblc8YsS6wVHtlUqz9NIYJ5OZn7ml6apuUc=;
 b=uYBIMLvMg9r/ZOwGJHxD6HePpybjrDmSrwNbtIJYvgRSrcfWVRaic3h5c24eIiIqJmaUBSlPW
 8XKbEuvtZb8A9rti2Mh6Q5HGTetYgo061eGl7iK6Gpzab9/0YztStRN
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

There are now users anymore which use old ThisModule. Also new
ThisModule did have couple quirks which where there only to probide
fucntionality what old ThisModule provided. Those also are not needed
anymore.

Closes: https://github.com/Rust-for-Linux/linux/issues/212
Closes: https://github.com/Rust-for-Linux/linux/issues/1176
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/lib.rs     | 47 -----------------------------------------------
 rust/kernel/prelude.rs |  2 +-
 2 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index dec1d05ebe7b..e709f85ec4b5 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -201,32 +201,6 @@ fn init() -> impl pin_init::PinInit<Self, error::Error> {
     }
 }
 
-/// Equivalent to `THIS_MODULE` in the C API.
-///
-/// C header: [`include/linux/init.h`](srctree/include/linux/init.h)
-pub struct ThisModule(*mut bindings::module);
-
-// SAFETY: `THIS_MODULE` may be used from all threads within a module.
-unsafe impl Sync for ThisModule {}
-
-impl ThisModule {
-    /// Creates a [`ThisModule`] given the `THIS_MODULE` pointer.
-    ///
-    /// # Safety
-    ///
-    /// The pointer must be equal to the right `THIS_MODULE`.
-    pub const unsafe fn from_ptr(ptr: *mut bindings::module) -> ThisModule {
-        ThisModule(ptr)
-    }
-
-    /// Access the raw pointer for this module.
-    ///
-    /// It is up to the user to use it correctly.
-    pub const fn as_ptr(&self) -> *mut bindings::module {
-        self.0
-    }
-}
-
 pub mod this_module {
     //! Access to the module identity and ownership information.
     //!
@@ -360,27 +334,6 @@ impl THIS_MODULE {
                 pub const fn name() -> &'static ::kernel::str::CStr {
                     $crate::c_str!($name)
                 }
-
-                // TODO: Temporary to provide functionality old `THIS_MODULE` provided.
-                // SAFETY: `__this_module` is constructed by the kernel at load time and
-                // will not be freed until the module is unloaded.
-                const ThisModule: ::kernel::ThisModule = unsafe {{
-                    ::kernel::ThisModule::from_ptr(
-                        <Self as ::kernel::this_module::ThisModule>::OWNER.as_ptr()
-                    )
-                }};
-    
-                /// Gets a pointer to the underlying `struct module`.
-                // TODO: Temporary to provide functionality old `THIS_MODULE` provided.
-                pub const fn as_ptr(&self) -> *mut ::kernel::bindings::module {{
-                    Self::ThisModule.as_ptr()
-                }}
-
-                /// Gets a reference to the underlying `ThisModule`.
-                /// TODO: Temporary to provide functionality old `THIS_MODULE` provided.
-                pub const fn as_ref(&self) -> &'static ::kernel::ThisModule {{
-                    &Self::ThisModule
-                }}
             }
         };
     }
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 2877e3f7b6d3..66974ec20ef4 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -43,7 +43,7 @@
 
 pub use super::error::{code::*, Error, Result};
 
-pub use super::{str::CStrExt as _, ThisModule};
+pub use super::str::CStrExt as _;
 
 pub use super::init::InPlaceInit;
 

-- 
2.43.0

