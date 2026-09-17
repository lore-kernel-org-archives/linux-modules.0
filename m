Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35203C1D7B
	for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 05:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621914; cv=none; b=ukJbnxO49dlI+ZRsBIZPyFS+98ALdhd5HMq6OFy6QpVs2CB7TlNCqUzSmByyfcKW8LqyFdRqk77HHLlLOhF8TQRiJKSFFHrzYpjewz03gFbcDa5uNVlKMJ9BT3MxsseWoyq1uTSgoYOKDmjEGG+/eD4kqOMySr7iztAeeJSrwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621914; c=relaxed/simple;
	bh=lb3pRdnJwvfKxjycac9VSWS+N55zVAR+aC6hInMK9DM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r5Vh2Ha7IoUthA1BruMR6DiqKn7Up/BrkaOW6nDT1PmfZkL0XE9vCm1zoSuTh48ZA7q3zILEWrMbynji/fYNz4pmh+6ZVNgloL8RA5jcffvzi5PQRaTf/ZcCxfAlM0ZoPlVjvakwdqhIAav9wDbKpH7nE5IisWAj7Bn9Txa1mTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnz2jPNa; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnz2jPNa"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dcfed75f77so7507195ad.2
        for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 22:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621912; x=1790226712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E9NMH99NXee9RAT13HJNCvuiZE1KlOsS2HDmn9ZS64k=;
        b=jnz2jPNa9/nHYRBH0YNVfDnbHNlRh8VPRubTyFNVF97Z7SFNbzSRPMYGQ0fjlIxGCi
         /35POSa9Zn+sxuzvRloxObTUep4LZfiDDu/cEiw9AN3ga3tHPWQ2RzzAenj9/j5Dpr9u
         QRLIB1StWCScvnmfFmtxMVSKdyoeLpP0SRUwPxSPilRdHm+1ajH1FR/8+p/5Y7If/hxg
         nETuVL5MwV3RU5YJadX7zacF0XgHnxpCVJalUSrv2MjD4qXaeLNCJbI4Apg4Ki6C+cWE
         671nj3VTUsek5BdAZ4EN75tYLdySaLcKJIvhNyBZANlnTWQElTpecn1//e8+GgMpSaTI
         MDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621912; x=1790226712;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E9NMH99NXee9RAT13HJNCvuiZE1KlOsS2HDmn9ZS64k=;
        b=q4w0GTFxd0trYYy4LYFLv467/s9yhvz+1KzlIh4Ihia72sIDPnCBY8QAdQ4XkInEO4
         1Ql0bfM+4NcTaVkXFCGJwzGV0zroNvdlYZWIS2/2CDc8xcdRzCiAtCe8G8yzcLT4H3iX
         dXhAOUe2X051hCDKt1ywBo4YWSzG4DUgVHU4hMrXF04gXjyp7q5a7Ozd8R6VnAaRJFoS
         /NhnOLIxpFAy5tTIXM8fYI0ziB67F1r005Ux47W5P1W5xO9CWyU3zN3uPB+Gh3Z5KzDJ
         nqHT4zZFJ/0CZjoqJg/Jp/7Dg4x1tL/sxuNXhdQGJwablONek6sJ2iWb1tSd8/BzWYLL
         dQ6g==
X-Forwarded-Encrypted: i=1; AKwUvBwT+msieMBT9B3TS4AEmECKTlzwpzshmHJqpmOd0FJLPpj3Xn0DZeO7V9o4nBg+p2BlD1fQg3fAM8LHDdnu@vger.kernel.org
X-Gm-Message-State: AFuF++lmoQ+wciBzg01urzd9VQLaV3+eGlaZU07NXuvVrPzJzxL4npRv
	JL9zmQ9BHZqDAcLPakySNvYa6HY3lH6V9TcVWjpM05UFugJU6od0x9BGHe2FBCExJegV8nw+pOO
	RcA==
X-Received: from plss20.prod.google.com ([2002:a17:902:c654:b0:2dd:a02b:23e3])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec81:b0:2cf:8131:75e8
 with SMTP id d9443c01a7336-2dd8e400f70mr111211735ad.13.1789621911630; Wed, 16
 Sep 2026 22:11:51 -0700 (PDT)
Date: Thu, 17 Sep 2026 15:11:47 +1000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917051147.98775-1-tweek@google.com>
Subject: [PATCH] rust: macros: allow non-ASCII characters in `authors`
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Module authors may have non-ASCII characters in their names. In C,
`MODULE_AUTHOR` allows arbitrary string literals which are emitted as
raw UTF-8 bytes into the `.modinfo` section, and multiple in-tree
modules use non-ASCII author names.

Originally, the single `author` field permitted arbitrary string literals
including non-ASCII characters. When support for multiple authors was
introduced in commit 38559da6afb2 ("rust: module: introduce `authors`
key"), it reused the `expect_string_array` helper that had originally been
added for module aliases. Because that helper enforced an ASCII check,
`authors` inadvertently became restricted to ASCII-only string literals.
Later, when the macro parsing was rewritten to use `syn` in commit
c578ad703ae9 ("rust: macros: use `syn` to parse `module!` macro"), this
restriction was carried over by using AsciiLitStr in `authors` type.

Change the element type of `authors` in `ModuleInfo` from `AsciiLitStr`
to `LitStr` so that UTF-8 author names are permitted.

Fixes: 38559da6afb2 ("rust: module: introduce `authors` key")
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 rust/macros/lib.rs    | 2 +-
 rust/macros/module.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 24f96feaeb34..ea2e232b61b1 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -129,7 +129,7 @@
 /// # Supported argument types
 ///   - `type`: type which implements the [`Module`] trait (required).
 ///   - `name`: ASCII string literal of the name of the kernel module (req=
uired).
-///   - `authors`: array of ASCII string literals of the authors of the ke=
rnel module.
+///   - `authors`: array of string literals of the authors of the kernel m=
odule.
 ///   - `description`: string literal of the description of the kernel mod=
ule.
 ///   - `license`: ASCII string literal of the license of the kernel modul=
e (required).
 ///   - `alias`: array of ASCII string literals of the alias names of the =
kernel module.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index bc7027f8dbb2..0a7b9e24c960 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -369,7 +369,7 @@ pub(crate) struct ModuleInfo {
     type_: Type,
     license: AsciiLitStr,
     name: AsciiLitStr,
-    authors: Option<Punctuated<AsciiLitStr, Token![,]>>,
+    authors: Option<Punctuated<LitStr, Token![,]>>,
     description: Option<LitStr>,
     alias: Option<Punctuated<AsciiLitStr, Token![,]>>,
     firmware: Option<Punctuated<AsciiLitStr, Token![,]>>,
--=20
2.55.0.1082.g2b9226bbc0-goog

