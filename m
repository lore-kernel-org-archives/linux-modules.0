Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE23346E63
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057769; cv=none; b=M0gG4o6imJig0RipUGdbkyN1/y7xmXBMyLdHgP5KcLVAfG6ZIhubH+vnwUsG0J2xgw34nUWbSnYDwwUdzxSS4CmjGlAbhStYbbcFTicKFH0CDrLxtfk20wQjuGN6MH/2o7LqB6A/q4XH6/R5JiPxnrnykIS/V0xtYEmnDWlWqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057769; c=relaxed/simple;
	bh=HXsmrNNEr+H1R93npODROo6Md8lvxfZavxKoxrx9XrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/3O5k6YToi0lP2BpNDScZClgAdmF9XWGD3YKRDm3yiv/pPN9bfQR0yUtJ6L6cUK3/0PilQewwmZ3UApQAeb6eEmakYguYMemBWPqJvEyComkWIyLr5u8dvIwXSa3zc4JECZJ1ZMKFQCu/Ib4Co7FlBMCY/F2Fj7vfcWUCXZGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtrT728O; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtrT728O"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b685d2b79so5005582e87.3
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057766; x=1768662566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jA4SPNhuMX5XCZ5OBbakMPi2P9GAq2DqeqD/xi+6gT8=;
        b=LtrT728O3amQSkF69AUmkAC7v5yMmQ1cauMk5K8evmhDhZBiizof39/SelMtMizRde
         sn4JS5sENOCa3XDLCe5bwrpe7aX/r6cRKm8Qe7K/ZaPfuajn6AcKa44VE+UvHNHcdjIo
         1PDLMasQtZa7hMUD1sHrphJHnSuvBVohEzeb03piE6Wp5JcrdZ5KgwYAFYTpspvyI5wR
         /oq9yNUKVUxCgxQwfy7QVv409/9bmX2xDJhMvKXJ0vNsUnHXp6p6IMN1IQBsaF7Hm/yo
         g5n3bQF0xCjHkdQ4TtBSejYFFF3anz27BK5YxqDE5EgBRvVq2LaDYDzIr+s7El9QzAcL
         Deig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057766; x=1768662566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jA4SPNhuMX5XCZ5OBbakMPi2P9GAq2DqeqD/xi+6gT8=;
        b=hui1AdrCh1R8Kbficqlj1DZolYcRnhQpNy1bdlIzA1rdsHO8lsrtMVpyoGXaaDVlIX
         RDlbqelxP36m4FiNSHeonhjUOzaTsmQN3TNJYHL70sVWMBHi52IPe0y1CTGz6qRNONPm
         P6fbf+trL2xM6/8OrwrZ27g9zbRJk+MZJdrqGNDqUZtlVBOuYVgOLDcC7h5pKBFKjIV/
         9ewm6mLJXegvEnJJmdGTTusYWFmS138KCajJqxmv01/NVjytuH+/GXJyOb2Sywuachhh
         oRSreXQ/pqlh+zZ3FBEqGT9ZB6wcWwcxXC6JTMz5yjuT8d7gxRkqOEmzT4T9MpjEvQBO
         oGJw==
X-Forwarded-Encrypted: i=1; AJvYcCX9NH7tmkWS2R91Y/awF0PJDZ+RoeXTAMg/0YAJL8BcUjKR54mWu89QWbyRfvcXF5RXGTS4hA20X53mqA/v@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKg7CdcCx+uFUu+ATmLzVd00Rt6ZE0lU3nyNZFaT1O0JGiCsw
	+9yYQ48D5PP+0XyL8+vHOrmp+u4DGewbpqlYqpHaVvb4wV43WkDk9RTR
X-Gm-Gg: AY/fxX4QV2ch1Oi4s392Jdgo888bXkmsBKeha9fyfLl4MjIfsI8OCAOujaCiOYgPV14
	SUTZutsiFfOHD/13pRpLWUYR4AivBJ0HOrglQP8WxpyyAsLUQcIQObyOH/BTPQrCQpCckAxq6vl
	/TVikyJmNZfrGkq+Y1rHN2vOA8u/ISFTeAKTAF0puF7x8ok7P92x6f4vtLzbAFg+bEjdFGmmQvK
	MuBPh6QbbwujNXItmGeCpvFG72aL2O4kycsFR+E0+h8lqGw5E8I8hYdntEaI+WdJac26bTC35jM
	mCS8wgKJsB+moyENOkHA135DRt0YWItD5v7VUw8tilotCUW8OGZ8EPliQGdH5kYRuSlSkB+8FQJ
	2m8u6RwhpWIErTZ1VyRm5exdckBilLKemMJZTZdpNKh+heayv8C7YLSbZq8bonr2jbW33g+vrlp
	peWE9+tUuVo++Z0gtAC+T56xwgOBMBqZpXoRGjlu2xlHG47TLQLu0c5k+eGMiv40RPO6W3l60n
X-Google-Smtp-Source: AGHT+IF5pkNobwqDdpJnVvMJj9HNo5dFu/TJZ8O4ycgXj/UHfAc8hmVO6+l9QbYPw5ZRrk2F06noMQ==
X-Received: by 2002:a05:6512:3d04:b0:59b:7fe7:eed1 with SMTP id 2adb3069b0e04-59b7fe7ef14mr1809283e87.28.1768057765447;
        Sat, 10 Jan 2026 07:09:25 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:24 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sat, 10 Jan 2026 17:08:05 +0200
Subject: [PATCH RFC v3 07/15] rust: binder: use new THIS_MODULE
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-this_module_fix-v3-7-97a3d9c14e8b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=1238;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=HXsmrNNEr+H1R93npODROo6Md8lvxfZavxKoxrx9XrE=;
 b=R0q/X1ltJqeYVBP9SobLKfHgM075ElagNogpcGU3GkRvQ1n9qSEzsNfW83i0UdVRRa/JUGwAU
 bxs1cBNamQBD2YNOSaU1QhJ7S2BuCHBpPzzaT5E05h1XEXN8E9VD7v+
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

We have new THIS_MODULE. ThisModule is now crate. This is ugly for
reason that drivers should not use as_ptr() directly. Currently binder
still needs it so ugly cast is totally ok.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/android/binder/rust_binder_main.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index d84c3c360be0..fc921c0e1116 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -21,6 +21,7 @@
     sync::poll::PollTable,
     sync::Arc,
     task::Pid,
+    this_module::ThisModule,
     transmute::AsBytes,
     types::ForeignOwnable,
     uaccess::UserSliceWriter,
@@ -319,7 +320,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
     let zeroed_ops = unsafe { core::mem::MaybeUninit::zeroed().assume_init() };
 
     let ops = kernel::bindings::file_operations {
-        owner: THIS_MODULE.as_ptr(),
+        owner: <THIS_MODULE as ThisModule>::OWNER.as_ptr(),
         poll: Some(rust_binder_poll),
         unlocked_ioctl: Some(rust_binder_ioctl),
         #[cfg(CONFIG_COMPAT)]

-- 
2.43.0

