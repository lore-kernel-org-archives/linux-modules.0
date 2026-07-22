Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA857473C77
	for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711779; cv=none; b=HBNrKkMdduK3gO8RU/mDBeHofLa3ziGtWT3z0PcXW94onK5pvUJPhIxM33LL9uvRZqrcgJ4gEOnvWRVxaEH0X5id+66rrprkKXVUWov7XCe7yg7IgFo1TpC/JVeDJ6HGuWbH9TsWiRDz6UDipGf/zD8N0F7Nlm8s7bzEQM1okCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711779; c=relaxed/simple;
	bh=YS3Fmynk4Vu065pQWcNaIi3zvRzKJ7fDLNwk2VrvdWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qxwIujuIx0yV1QABFWsz4rBfswzLTkyVNuNxTJnVGs7Y7556ktqXbbrZuFRLd+wd0mxohCamStFAZBxcfXwlJHWnSUlLalnHq5BEtTg26iVBNkhNzgHmd8mI6Oy+N+4cUWkBX2+Q5GeV9IcyBQm4kJ8KgAm1PraV/mPimnHyPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSP5xUb8; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSP5xUb8"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-69c20d1d150so8060989a12.0
        for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784711776; x=1785316576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fy37Ri9YIz6ZPyFsdkNre42EGivj6QW6c9T4HBOMel8=;
        b=SSP5xUb8jBbiBRcl2OSRVX98UaqLtcRAehMeYD/uFSIovNEuZ5wMdUY5HDWzQuYME8
         L3Q6ZtGmOCA21ZF2YBnRfyNmrbULNOFf+eXcr0rTf0a7KZ/JJRsJ3LFCm7044BVXNBgD
         UHlEVxqG88YIpwkvOLm38WCj0IZhnmnqo1yHlf/FiyK3OocMO6Dh2Z8UqgaKWQ2F0Do8
         ptpjrOAUjPSeE92yQhGFNSCtFur172iUa4yVrjI7yU1LU11thaIC9l1U1KywEbhw7cOL
         uESVLkRwsnOHfaudGvQhVnOB/r8LEsjZxs6LP2x5xqOu0gHRnkaxW6Nfb7BcdQOIFtqQ
         AdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711776; x=1785316576;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fy37Ri9YIz6ZPyFsdkNre42EGivj6QW6c9T4HBOMel8=;
        b=ppjPA20ueTZkmwhHdJvxbGgF6YfwGVtSzBn1T8inXhK+a4toVOWkGs9BmXAVFQCCYk
         pm3Ijm0AICg/efVMBf/ryUl/Ayq41OX3IlLDiD/pW+YZxYVGWvkX1tZd4SLidkPU1Tiw
         8p5Yz+reefimBdRdgTB5nGguPRwrvF7cvHIXKTAMbkY/YThvEoKZn2VOrj+7l+a7ixp8
         zx8TKdqvNPuRDReNwz4w0+ys7bZ6ExK126xzP/h39B+c6XbW6Q/fc58DSGO8xicP+Dw9
         VUDLAqlu/mpAC25joktJscSulkYO4AldDhn0ZtEPGLp9a1pVjXIWCi7BoVT8DGwnOrVs
         bNqA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2nxYsk8MVeP4ZGOlv2rj4sddhDed7Xfu2jDN6o/qnCdXnCa7IGtVE4iNx4X2F/2Zer+ii/P/2+4Llsl+i@vger.kernel.org
X-Gm-Message-State: AOJu0YxjV3ySQ+vJhvaRU3XRPPLq8D7QkIMFPXpUjnF6pB1CoMefANS6
	cv2vibfneNB0vwfJB3iYcE11NGw6FjCJ0/fcMOUV/zdQ+KUeNnd0Gny/WOn5bcmSxMAzM+vRNtD
	b9B+f2hrYHojxaPjCiw==
X-Received: from ejfx13.prod.google.com ([2002:a17:906:a4d:b0:c12:697d:b9f0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:60cc:b0:c1c:3705:dde9 with SMTP id a640c23a62f3a-c1c3705e054mr91273766b.64.1784711775265;
 Wed, 22 Jul 2026 02:16:15 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:16:03 +0000
In-Reply-To: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3202; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=YS3Fmynk4Vu065pQWcNaIi3zvRzKJ7fDLNwk2VrvdWo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqYIpZlnR5r3GHmC1/FYMSNnDKWRI2sTd2Ccy2c
 Wmxh6BdjE6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCamCKWQAKCRAEWL7uWMY5
 Rg9OD/wIyDyEpfmqc72tRFWwWjifv2M5J+dXWO5bI1owZFLjoN+qloMJOeq+T9l3ELsHO2qW/2c
 NywU9nNrj1DVaZ2mgsdfH+P8TKEKOYvZjfKqCSfPfwmZcrM5j+M9FC6QNA8Wqlg+qg1Jn+3iPgH
 znS4RrASUWE+ns3BSx79z6svYO5KUCJefKa9LHO6eab9N1+hc5r48t70jQJvbdsJG6dZHgVWaqv
 HdCwAScNPhtl6r3kikGp3XIBOOEwAOs6joXmPXKvuJxpncn65IO5ZU/w3zmJtPZh4jOOK4AXvHs
 lqb3Vxv0vidryGAqKq3365w7pXbGmJ4pjjocjC4/DyFzvfqYFeeu1rTQ5gbS33R2F+z3a29L4vr
 dBG2FTgKtmV2LkrHgIn4F986mDrop4xGWfqK4PCfEeKV08DZ52cSFL1fukMR6epA3f1xPcv49PX
 BJjG87jJWm/pz+6dSoQ4+G+8JhNWl/737CBWcjqRYQO5YJUi0+/RcOc5EHR4ijw3ZiUjOinYm4+
 qUEH+q+cdq9JgGN9mlxFAfGKdrHrS6XF2ohMRDO/HPU4EljxWalnBrveDrKb+c6tFMxBIpp3QXs
 52JFVAi9DR1R8qZ9nwGAr8dkGZYqwsPqTuvNWxoWLPDfBzPeS1xiAqdAQih9qhEuWQTRH9Ahk0z 2a1Z7WAPSU5/nwQ==
X-Mailer: b4 0.14.3
Message-ID: <20260722-setonce-populate-v1-2-fa7455c26c42@google.com>
Subject: [PATCH 2/3] rust: sync: add SetOnce::try_get_or_populate()
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Lyude Paul <lyude@redhat.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	"=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The SetOnce::populate() method does not internally synchronize callers
that fail to populate the value with the successful call. This means
that naive loops using as_ref() and populate() can lead to spinning on
the initialization, which is best avoided. Thus, provide a helper that
avoids this issue using a user-provided lock.

One potential alternative is to change populate() so that the failing
caller actually does synchronize with the successful call to populate().
However, this is somewhat tricky:

* There are users of SetOnce that construct it in const context, and we
  currently don't have the ability to do that for most locks, so we
  cannot easily add a lock to SetOnce.
* Just spinning on the atomic is undesirable unless we disable
  preemption in the success path. If we do disable preemption, then that
  raises complications for handling the PREEMPT_RT case.
* It also raises questions about deadlocks if populate() is called from
  irqs.

By using a user-provided lock, we do not have to worry about these
issues inside SetOnce.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/set_once.rs | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/set_once.rs b/rust/kernel/sync/set_once.rs
index a78f8c8e87db..d9cc598a8d78 100644
--- a/rust/kernel/sync/set_once.rs
+++ b/rust/kernel/sync/set_once.rs
@@ -2,11 +2,18 @@
 
 //! A container that can be initialized at most once.
 
-use super::atomic::{
-    ordering::{Acquire, Relaxed, Release},
-    Atomic,
-};
 use core::{cell::UnsafeCell, mem::MaybeUninit};
+use kernel::sync::{
+    atomic::{
+        ordering::{
+            Acquire,
+            Relaxed,
+            Release, //
+        },
+        Atomic, //
+    },
+    lock, //
+};
 
 /// A container that can be populated at most once. Thread safe.
 ///
@@ -104,6 +111,34 @@ pub fn populate(&self, value: T) -> Result<&T, T> {
         }
     }
 
+    /// Get the value, or populate it if it's missing.
+    ///
+    /// This method is useful to avoid spinning on the internal atomic state. If all writers call
+    /// this method with the same lock, then they are synchronized with each other and it's
+    /// guaranteed that no caller will attempt to invoke [`SetOnce::populate`] more than once.
+    pub fn try_get_or_populate<F, E, U, B>(&self, lock: &lock::Lock<U, B>, f: F) -> Result<&T, E>
+    where
+        B: lock::Backend,
+        F: FnOnce() -> Result<T, E>,
+    {
+        if let Some(value) = self.as_ref() {
+            return Ok(value);
+        }
+
+        let mut to_insert = f()?;
+        loop {
+            if let Some(value) = self.as_ref() {
+                return Ok(value);
+            }
+
+            let _guard = lock.lock();
+            match self.populate(to_insert) {
+                Ok(value) => return Ok(value),
+                Err(ret) => to_insert = ret,
+            }
+        }
+    }
+
     /// Get a copy of the contained object.
     ///
     /// Returns [`None`] if the [`SetOnce`] is empty.

-- 
2.55.0.229.g6434b31f56-goog

