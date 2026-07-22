Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D448164C
	for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711781; cv=none; b=NIcRDSmwlSLkA91SkkX1m+i3CVCZYdQzAlJbiTxXF49d9HTsriZk7zoGw0H6cybvgJU3Ec4ojOQkCqXaPjNvCPLw/Aa9mIffdli8H3CC9AAhpzmGQzwld6pKRZ2sGzzYzOSP4MVW3B5fKDG3PjadN1JH4WJQcUchkHJkuLbhEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711781; c=relaxed/simple;
	bh=2b6L2eXi0rZnUWrbz0nUqiyHf39Qr9F7UnkV1u9przE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K4/OUHlJNo1CjyYCY9pPvHevmKSCw8NCqNUILZLfqBSuL486nAVQ1CgIuNaAzZkDxmyizCx/cJ4bgwffh8vC/NR+d96kLUU9yqxOZ4fKwmEO06v1t6mbe6Sed2B6naolndsV0Bih8XQgyDCJ4LiE1QNPn3KsmZD3dU2sAfiK/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YB1hT2Gv; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YB1hT2Gv"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4956b4cfe19so4451645e9.0
        for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784711778; x=1785316578; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHBSei75Jv7bmuOghRwfWU/0mZN/rXuNg2tLxsZDtvs=;
        b=YB1hT2GvAeEiWo8YfZ5AvpmdyHS7h237sRsrCYqFn3iDOa1Zx2dmsqmgQnjCaNSxSs
         m1zhNbXz1aF6O+4O0LEBMgpcaJp2XQ2UmzigQMFMzRwnuYOT32BG3K0lu4ICzp1X9Tpl
         G0X7iPEilk8EA4RJsWgW1W2PQEk+Obpj02xbpLR5TojXB3YDjcv2wOf3S45eIvfHMIK1
         nDf81gq/BMg0kmLTLfn+kwJBNirAR2LlJLW+w/aSAI7mKp7awMjB6W+k4LA8iFrxw6Rw
         FovALdo3TTGwEQlfyURWPVLT4d+hetl7A066LfCgVr8cv/hmPXaKyeNNqp0Y6hwChrAH
         lcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711778; x=1785316578;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHBSei75Jv7bmuOghRwfWU/0mZN/rXuNg2tLxsZDtvs=;
        b=rWp2ixVbledxixo9n/3vJKVa7QEgFPIcCmeImHgxYnWSuH9Xy73mnHj6Z6NQgDnoyK
         PtcRFHYCkh3PE1SGa0xKCHphAmwFCmgcsAfWCL0EiSslsW54XeR/UnQYkjYaF0ccDXXe
         QKwLxyYVehMxNBgs3ZHH5//+1dkdZRDRalht/tL4Fa6C+lZmnFUkjjpeIrSQfMaETjCZ
         GZlfy9/kt8qY15jsbF5UNSOTOElqCmh/jC40YjAwBJEFg+m7vX7opDnMo0h8LOGGqMwd
         w7YL94XosVr4mYxKLgcIGlUohUQ9HzsSOAVxOwr3RQXuJn5zqH+iBLiSzjK6VvyI8lEN
         wZ5A==
X-Forwarded-Encrypted: i=1; AHgh+RoaL7jIyvFINpWE2FLTllnvFYBDcYAecdUNmQZ8tOY/asDOO6VMQDx/h6KS9kSEL1vpxi64Ck4//FxvDasd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Z/pl8Tm9euVgqRo18YpkUggSQzhSCmKW76kb6lCvCzdKIApc
	NUAcDAx7kq2gu84Xf1t/unLj7T7c+FDGCnvlmmU6qfoJ8cuNt3oB5odNJmpeq94yE9eL0TsyhtE
	0G2CHxTmSt2Nvg/LAiw==
X-Received: from wmbhi18.prod.google.com ([2002:a05:600c:5352:b0:495:5422:15e3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3512:b0:495:4572:21af with SMTP id 5b1f17b1804b1-4954a3ef7dbmr238679855e9.9.1784711777195;
 Wed, 22 Jul 2026 02:16:17 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:16:04 +0000
In-Reply-To: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1836; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2b6L2eXi0rZnUWrbz0nUqiyHf39Qr9F7UnkV1u9przE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqYIpas4y/7rCjWTJa1nAy74sXllLbFrMDrj0Ke
 vy4i59SgbuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCamCKWgAKCRAEWL7uWMY5
 Rg83D/91oaUidxNFz+BG7bXj+iXTwCt0prL+qV9Z7JDRS4YVNLFzSMLysmQnwkAs89FOGktC1bX
 /LF47L1f+xCN7sQnmt52IHGocGVMMX8ntn8IRGVYfyzAK5vU3UD9UJMgOkopKOM/jmHyk1yi/Ez
 /x316krIN2LBbvT31uAdrWfdshY0UxPyJDd58Rucq4jox6877lYKvjXDQ6Krnyah77n/TrBM5YE
 pueY2ruXcv7io/gR9bbzzMmhyWm3kddrl/72hIiKZ+5NgdPEo9zhTBsFZl1v9957VcJsLZxVvYw
 /Ztvs3ZgG2rhYsGqZnUEmEDJhxwqnkB7X3l5o/5YRF8byR+JxcCAiilGgSzfEA6UBF4Cd+JnxZz
 WbL3MRgOUY99fMXLEisT/jtUrbPEY1KkdiQhnh7MgOdeZ3bukpp7+spkRlJ/v2R1V8hAdPR+08G
 bFxjIX/tM4/Y8POiwXPJcRHPqz7qk9uRgG6stA6kuN1/aHXs41H8uzk1HuCMy8divuBw2ysSt3B
 bazrD+E9Pr4eBVw/iMpyaJYPscnjw3uOnNcw1ljY2KAAmpHxCqGO+Kb40Yumnfg29AwJvqAVlDF
 IyAODTBskJo4ITfA5eaNB1GcLEhLSqVTPHaO2U3IhHdqf6n8FYJe0XIu9fD0voijdMnT+NbGI/M 1gpBYqrmeRvAKhg==
X-Mailer: b4 0.14.3
Message-ID: <20260722-setonce-populate-v1-3-fa7455c26c42@google.com>
Subject: [PATCH 3/3] rust_binder: use SetOnce::try_get_or_populate()
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

Since this method has just been added, use it instead of open coding the
loop. This also has the side effect of dropping the PollCondVarBox
outside of the node_refs lock when two threads initialize it in
parallel.

Suggested-by: Boqun Feng <boqun@kernel.org>
Link: https://lore.kernel.org/all/alJHCkMIcnXYPNoJ@tardis.local/
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index d486bf7c0b8a..5f8779badd3d 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1793,21 +1793,12 @@ pub(crate) fn poll(
         table: PollTable<'_>,
     ) -> Result<u32> {
         let thread = this.get_current_thread()?;
-        {
-            let poll = loop {
-                if let Some(poll) = this.poll.as_ref() {
-                    break poll;
-                }
 
-                let poll = PollCondVarBox::new(c"Process::poll", kernel::static_lock_class!())?;
-                // Reuse our existing lock to synchronize callers initializing.
-                let guard = this.node_refs.lock();
-                let _ret = this.poll.populate(poll);
-                drop(guard);
-            };
+        let poll = this.poll.try_get_or_populate(&this.node_refs, || {
+            PollCondVarBox::new(c"Process::poll", kernel::static_lock_class!())
+        })?;
+        table.register_wait(file, poll);
 
-            table.register_wait(file, poll);
-        }
         let (from_proc, mut mask) = thread.poll()?;
         if mask == 0 && from_proc && !this.inner.lock().work.is_empty() {
             mask |= bindings::POLLIN;

-- 
2.55.0.229.g6434b31f56-goog

