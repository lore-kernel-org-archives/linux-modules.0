Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98623EAA3
	for <linux-modules@vger.kernel.org>; Thu,  1 Jan 2026 05:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767244896; cv=none; b=TruSfrf0yiRykUlxMklbkN9NTtcz1aYA2cY1qR1jxlXVpA6rrZiVidHnLldmb4C/VQCihkfT/BGDtIUdILwWm3Ox7wGWpqa9W0PRC9ahj0gohdZyr8emC7Im07EhJvyjONR+LUga/eN/++EHJdB6ZIq9ACfbVHXqRl1MVoQr17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767244896; c=relaxed/simple;
	bh=oU8AXbLPxfdc2yPuZDO/6a4+snqR12Lb8r8RXRuzo3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knkDQb0PguVL7DAO/zX4JROoLKYcfQ3Lhme6tN/EBQswrlx4sJ45tDbxhVyLwZygxUt6ItUYaOj7ddGzzvjSyAIxkt9/juG9WqmK49Ylyo7OMifSxGC4hacGCp3mX9IObyqKJqtacnbtmrFTWyJRspj4AQlJYWPuyZcfqTK3IVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAoxeEDV; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAoxeEDV"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37b999d0c81so94973501fa.2
        for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 21:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767244891; x=1767849691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHOwRzURK3HvR3V48oWkPaPLxKL+jt3ZSgRna/0IJ4U=;
        b=dAoxeEDV4GElskcjlC3fnacaYdAKC82LNc/oN/g0rYBPStYWlIJmy1Kw20o85dtcbz
         evawp3YLd6O51yoEzEBKdD4KiAm9Sxy1X4mGgX3WlzOecZHRObdYdCHxDpOLR86XHeT+
         lKpM+Z0cuLTO1Hmzwn9yyhbsNiEEje5u3tcnf+yYlcnfR4cGjFtedpRqsdP7Q7EKwOap
         x7wsilHJx8xDFNmVKCNiXtioXA+m4mrDHBBJ4o26o6i7+ahcIu72SBS95Sw11UFINBpR
         XV1E1mF7vak2XGv99xdifiVHAMeY19lr4l3PNWDSTMtnNTQbWNeUFpiAX/t7vn3ZjkUj
         VXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767244891; x=1767849691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHOwRzURK3HvR3V48oWkPaPLxKL+jt3ZSgRna/0IJ4U=;
        b=U59WusIjGtyqmGtZ+QdLQ1rC5dyAOxPdrbBTaAn+HDnjTJj4TPkIYDoSEG56TjawfP
         3USQCaf/fjaEgqBE7sv84GklMcs+WAZbHRiI/7icqP6xNReVFJZ0o9gbb0YUjXHPuSut
         6c8k4WcSqILz5FjR+C3LKUcRiATmjxUM2AkLPx88m2T36/ZxOs5vryJ92hpK03hZqLUU
         plPJ+e3l1Ltab0iEP6wXZTnz62vVVDg13bVuXUqiayZwIZ8ml6vVUvqzAJsV418vHKsO
         TOX2MMTQ4LE0QObepDiwNM7Q4jCw1u2tyxGyR+zmW4lXtY/imjMF6URukjMc1ySXZaU4
         CFrA==
X-Forwarded-Encrypted: i=1; AJvYcCWYEJkIvwoK4ad3UAacZWOtIRb2VHygHu76h0XTBTTvGwevudogJZhKgjshoMCVt2kuV7nYaYE4X2H76wnj@vger.kernel.org
X-Gm-Message-State: AOJu0YxAG/7xiDOL7izkIVh5zgiyKoj8mDjjfi7HwB0PWh6O0QYC+PI7
	1wcHK2mo6T9BHGf6LKLEJdN+sFUnT3059w+lKsdmYgAPEOYy/EGOpxVr
X-Gm-Gg: AY/fxX6nXjiGGpbuviVt/siq20xmQ6x+fRTHnG6JCtanmhNxDT+rAeJ6Ms/AJk5r6o1
	uUjisVkE/OoFHxVu1U0iGNoqNhQP9owx2mJNcMFYkK1nKoUJbovLANCUL3jKO5DdNaA/Qt2EW0n
	wENkb7nbe4C8rWTL9cfrrqzBPihHSs5dQ3//klb2r94D7FG4kCBWQaDmZZ7KpojyMMzAMotBekR
	2onu8SHz2dnUyKpuW8RS2gxbipVJz4gQCYhmDMv4wTMm05Wm5f+VK1HOYMNdcrRmVGYgyxUMT/B
	R8V4hxu04GQQrFcQFeZI7fkKVlZbfp0GbUS4g4Xt4O0Or7fHWqZWigwXfH5qqbolBCEPm1inoVG
	Rj+FeggGAG8l5nm45wCNkFtIAjozVj5cNar8rqZuQY9bvZcizSnKNQa5w2foVJrG420l/W59e8e
	3XT0f5TIMO73NdrCZBl/WVk1S5lmhevO/XiNdC/rCsiorGAUbK69wNgUj/el5+hP0HpfCJoP9k6
	S3LBw==
X-Google-Smtp-Source: AGHT+IHEv+kPqKymr4VXmqTi30FJOewT0NTEHSBAdMfCqJgglKj7HSTDJFJDDr6fr8BgfLO462XPUw==
X-Received: by 2002:a05:651c:b12:b0:37a:432f:8ecc with SMTP id 38308e7fff4ca-381216724dcmr135823501fa.33.1767244890832;
        Wed, 31 Dec 2025 21:21:30 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (84-253-216-54.bb.dnainternet.fi. [84.253.216.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382861ef4ccsm37064921fa.23.2025.12.31.21.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 21:21:29 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Thu, 01 Jan 2026 07:20:45 +0200
Subject: [PATCH RFC 1/6] rust: Enable const_refs_to_static feature
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-this_module_fix-v1-1-46ae3e5605a0@gmail.com>
References: <20260101-this_module_fix-v1-0-46ae3e5605a0@gmail.com>
In-Reply-To: <20260101-this_module_fix-v1-0-46ae3e5605a0@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>, Kari Argillander <kari.argillander@gmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767244881; l=837;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=oU8AXbLPxfdc2yPuZDO/6a4+snqR12Lb8r8RXRuzo3k=;
 b=IGihzG2buaIXq6V07kPH6f84Q1eDKB0tLDVGw2tPrNwji1/UqRfEH5cLGqRiecwlWj8R9P3WQ
 KHN72I+wjixDD6J81u60QyxyE/AWhjyCf1H9TuHy54eIUeQ2OQ04qoX
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Enable the const_refs_to_static Rust feature to allow taking
references to static items in const contexts. This is required for
using ThisModule when constructing static Rust structures.

The Rust support already relies on features available in Rust 1.83, and
const_refs_to_static has been available since Rust 1.78.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/lib.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f812cf120042..69a798fbb563 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 #![feature(const_option)]
 #![feature(const_ptr_write)]
 #![feature(const_refs_to_cell)]
+#![feature(const_refs_to_static)]
 //
 // Expected to become stable.
 #![feature(arbitrary_self_types)]

-- 
2.43.0

