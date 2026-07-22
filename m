Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495C48094A
	for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711780; cv=none; b=Mt3jw5YTXfw8eyq8SwAZspS3ge0LApozFGiZqxWQNInqSS6G9fhe4eYuephJNt3F29eTW8kcqJGTfLAZ5aoT9Wwza6Q3OoQnq9lbXphZqJK3Us4M990cw6P581+emxH5guow+oOesgDK56bzA+Oi4GDu/+t1FqVcUeoIpCSMrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711780; c=relaxed/simple;
	bh=u4jslRub/PBLu8EohlDte+iH8SJg/CCqcBJNUYKCNsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jDEWI4ODbyOKnrq+Dx9MrybJaDNUmeUljx38LC08D9M72lmSnQcPRa+vhF8U1ilID/MJ6sIrGsIyOOc+RUVW8ydoD/5SugIhrqKrxu69bVhpc1Lhgci7XTGcfhM6MOVFrIixh0NOok9cwqeRTTsEvYN6cEwY7tN+CiacNNScrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZjO3thq; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZjO3thq"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493e94719e7so83043915e9.0
        for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784711776; x=1785316576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6wf+HdlcLWSsWAu2Uuz3MUCnLI4Q7ndCuVYUgFzi1s=;
        b=sZjO3thqtdj4nAwsIzEsaG3vNemylX4sNtZYgNTEkFk74LoUJes2z11X1MNN8G9BwT
         fH7SBXDI/YS4+4gPmWd8eyawRZc+xXiNH2Xx03v9fifh4v/xmAfPMGJi8K6Qu4HR/y/X
         ItEjQayJ/0alLDlZQutyCi7Lo6gprmx+CQZ6T9ZEYiMOnveTauF7P3dE6rO/Hqv13aB7
         yXuycY+iH20Vpe6PPlbPTC6n0gv3t6OMgkF9tdzp4WzI2IVJA14NMV0RlfwxgDEzTd+v
         1ASoBBD8X7YHhYrP2j52y4ac8XGeCQrXA91IA4G56nOCVgA04+CtahB5S2EPUNwJGEnr
         2HPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711776; x=1785316576;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6wf+HdlcLWSsWAu2Uuz3MUCnLI4Q7ndCuVYUgFzi1s=;
        b=eUvmun6GiG0A3ND+Wh2DiGH7czmM4jau7YeSVTJh8nhf3U3WPRPap/pOOvRDNHyIz3
         MoKWPOu3Pn51hNumSlsGZxifiIGAnWSBHXFuAARa0lDWQLQg8UVqS86p16dYAoKztwtt
         0pgMrGwqIv0Nok4SqItZa2xuGNIfjXDTQwKZOXLiwF+PKanTNpeLuHnG4hAgopnw2drN
         bxz9JaV2e9S+rF8vUWbI65D2wXMsHhkXRCSL6slMciF0TM/9QldFSPLhMlXDYGhfgM9k
         6yTuL6sZci8BhKlQ7wyeOi1OAGKe2d6kwlE3wu+uqBDO8J89dJ/CWf1Fi+j/KYnUlmPV
         ctVw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8clv5G/78hK50M1x1MNhDr7OWGE9PR4tVxeUw/BuFBdhgdtfAALUWM64BZiolyS5e4jHCebI7935ZnFFX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5JHuz9f9lOyAx2bAfigTGcAfXVRlFVBqUFsGV+7ylqJAziP3n
	uAJyezd/8jdwk9njPYjeJGPlCHF9QSNQNdPQh5JiTsKelpBMbZ1PGor7T/dDammtStsR4LvkGM0
	IEgJO8rg/rjc9JDJqYA==
X-Received: from wmjq24.prod.google.com ([2002:a7b:ce98:0:b0:495:58ee:fab7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e88:b0:495:636b:e519 with SMTP id 5b1f17b1804b1-495636bea4dmr113274575e9.21.1784711773573;
 Wed, 22 Jul 2026 02:16:13 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:16:02 +0000
In-Reply-To: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4250; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=u4jslRub/PBLu8EohlDte+iH8SJg/CCqcBJNUYKCNsc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqYIpZN1A+6gDJtKxTSNtQ+QUZnSQ+eyH+mifN5
 gc2kpqtgZaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCamCKWQAKCRAEWL7uWMY5
 RtptD/0am6a0c66NvBFWZW2Nw8qvMbfsQ7z5ejBurSxnIC0W3Fk12HDapsg1fBGeEQnnZq+U7oD
 mARdTk+ifzUqVJwefmcgX5u6Mzvcm0g6K6sEar9EPQr4aVUtJ2yEAUuvEGeVyx1szusd6eID5Ri
 WPn6hfzvW9YMeiCNBeYEbJBgp+wvzV/WLwHAlPrLlVqH9/sVE1DF1UEkO0CqE89tWnZRWCsaBiJ
 sg7PcJlDEtZl1FkfrW3bKw+lwPut7frasv4fmMnDwHdrC7XhqH5MdEwqzSIDgMFv82wD7Uh63zA
 SeP+oZpv3HyeXDDoZburITwY/sqqsc0dM+yVFjctlPGPFMpkwqw6TT9YFgCv3IU8+C9wVvNixrd
 ppEbEukJ0c3qjKt1FiqiONqdCpGF5O62Lt1nxPyDiTTCo91h12tkjCZjgNskMRvxRJkwm1Y8lat
 NZ1tB2XfqgsXshennGUZ1tiZRjPqTCG/bkbsqe2jyJqNOzCF/qZ6QpwHxo/eex6c7kIxdgcfFpq
 dHVXKBlk4FN4t9WKsFe+UIDJUHQDY/zfpTo4cT4OvDy29HiHv5eNdsFjshzOTCBsHcNmQ6kp0HI
 uFUaOLIXr9/2wX0Q1ahBHb6/X792S4D25LN7purjrRPSgeuoBVTj7E5fNb5q6u8mDI7ahfLzJqc wRbsdDsVNi1ezwQ==
X-Mailer: b4 0.14.3
Message-ID: <20260722-setonce-populate-v1-1-fa7455c26c42@google.com>
Subject: [PATCH 1/3] rust: sync: return `Result<&T, T>` from `SetOnce::populate()`
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

When `populate()` succeeds, there's no way infallible way to get the
value that was just inserted. By returning &T in this case, such
infallible access methods become possible.

Additionally, when `populate()` fails, the provided value is dropped.
This has two disadvantages:

1. If the caller holds a lock, the value is dropped under said lock.
2. If the caller wishes to use the same value for something else, they
   can't, because it's lost.

Changing the return value to Result<&T, T> handles all of these cases.

Rust Binder is updated to avoid a warning about an unused Result.
Additionally, ModuleParam is updated to correctly translate the new
return value to the right target values.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs |  5 +++--
 rust/kernel/module_param.rs       |  8 ++++----
 rust/kernel/sync/set_once.rs      | 15 +++++++++------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 1778628d8acd..d486bf7c0b8a 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1801,8 +1801,9 @@ pub(crate) fn poll(
 
                 let poll = PollCondVarBox::new(c"Process::poll", kernel::static_lock_class!())?;
                 // Reuse our existing lock to synchronize callers initializing.
-                let _guard = this.node_refs.lock();
-                this.poll.populate(poll);
+                let guard = this.node_refs.lock();
+                let _ret = this.poll.populate(poll);
+                drop(guard);
             };
 
             table.register_wait(file, poll);
diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6541af218390..8f0bd085badf 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -77,10 +77,10 @@ pub trait ModuleParam: Sized + Copy {
         // SAFETY: By function safety requirements, this access is safe.
         let container = unsafe { &*((*param).__bindgen_anon_1.arg.cast::<SetOnce<T>>()) };
 
-        container
-            .populate(new_value)
-            .then_some(0)
-            .ok_or(kernel::error::code::EEXIST)
+        match container.populate(new_value) {
+            Ok(_) => Ok(0),
+            Err(_) => Err(EEXIST),
+        }
     })
 }
 
diff --git a/rust/kernel/sync/set_once.rs b/rust/kernel/sync/set_once.rs
index 139cef05e935..a78f8c8e87db 100644
--- a/rust/kernel/sync/set_once.rs
+++ b/rust/kernel/sync/set_once.rs
@@ -31,12 +31,12 @@
 /// assert_eq!(None, value.as_ref());
 ///
 /// let status = value.populate(42u8);
-/// assert_eq!(true, status);
+/// assert_eq!(Ok(&42u8), status);
 /// assert_eq!(Some(&42u8), value.as_ref());
 /// assert_eq!(Some(42u8), value.copy());
 ///
 /// let status = value.populate(101u8);
-/// assert_eq!(false, status);
+/// assert_eq!(Err(101u8), status);
 /// assert_eq!(Some(&42u8), value.as_ref());
 /// assert_eq!(Some(42u8), value.copy());
 /// ```
@@ -78,8 +78,9 @@ pub fn as_ref(&self) -> Option<&T> {
 
     /// Populate the [`SetOnce`].
     ///
-    /// Returns `true` if the [`SetOnce`] was successfully populated.
-    pub fn populate(&self, value: T) -> bool {
+    /// Returns `Ok(value)` if the [`SetOnce`] was successfully populated with the provided value.
+    /// Otherwise returns an error containing the value that this call attempted to insert.
+    pub fn populate(&self, value: T) -> Result<&T, T> {
         // INVARIANT: If the swap succeeds:
         //  - We increase `init`.
         //  - We write the valid value `1` to `init`.
@@ -95,9 +96,11 @@ pub fn populate(&self, value: T) -> bool {
             //  - We release our exclusive access to `self.value` and it is now valid for shared
             //    access.
             self.init.store(2, Release);
-            true
+            // SAFETY: By the type invariants of `Self`, the value is initialized and will stay
+            // that way.
+            Ok(unsafe { &*self.value.get().cast() })
         } else {
-            false
+            Err(value)
         }
     }
 

-- 
2.55.0.229.g6434b31f56-goog

