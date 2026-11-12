Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485718;
	b=D9vk7Jz7ROQnReJcROmOCkYLBTpV1PjBLyM80/BVN51V89jR1WK1Rra6W5v+gbx9Lfay
	 L395R1+F53XXTabpq7llKcmKPCSeVQT/8lAxJVDvqHHyLRRvAqkyGByNMcLkMeEilSZsi
	 Kt2o+P9ZbJ880+GBVyb5iaZss7Mikmotj9LnUXI3n7tF8VGPpyL5JxB73b5PZpQOW38vd
	 iPg8s4Q9ZNuBhoJwUgGDGmFVpvaTxRCllykHPLyeVDTuJzIllAGUkOg87uVlbUbn34jdy
	 5fD/RTIJlHPT1orgBogao8kDkarxhKku76DS3DbU6vgYVIM09nSALlvI/eHbOReVP3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=w8vKr7ISurIa66CKb2bSb0lWJTyTbVCUKm48dux1Buw=;
	b=xsTjdpN+Pg0j5dhnkaP/VUgskeHAL72BTXD6/KntS5x2MBk43KgI5R8la23hMFaeG3GG
	 uIiwhnB8jMiRrFonX6NluGgF71eKKHYatQol1wB2WP2Eypr3WVN3LaM0L8V/Nh5EKm8Ri
	 gaFjrq2GQQz/hDTuc463DySrYtT0E9rT2xCHvdjmNlH/DHD6soVG8r0lSJrLG9lNyfVqE
	 VDXkFERhR3ov2VB2SiN/fX+CirKywrWyjyucNF5dnOsAAEvBFS6QYeGpZyWdFjzcvwtCr
	 MJ2fg/V3UaCAObk6g2j08xeRoMUjAbcFlQttHHFQlN7lNfTbLvRimdKpYT7jToEX3xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CyLQtps9;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2C606A327
	for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 12:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76A2C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CyLQtps9
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b9f8c66f72so4014985e9.2
        for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 04:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794485717; x=1795090517; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8vKr7ISurIa66CKb2bSb0lWJTyTbVCUKm48dux1Buw=;
        b=CyLQtps9UupiTq6Oyph34jI/sl0YD7FgTwqNaa/INSZs87ZFaAYcf2O0E6XvG1/jwp
         C75DCPwoJq2vlOD7u2gYNgNiGHeiVy3b3CvCNZLexjOtzj0y7qe8mmjV5Ljplzf7F8l+
         8A7scmBG/ekrQ/z0NrHniU1sxw1I6Khw4KAgnR7uaZmyun8Aiw/9uOTUCFW1/D+DpOWO
         GO+eHF+vQsPxGfnEOgycWzLm9vEV7kSftzxSuq0mf1TfAtMcW4H0gA2Zd2GmvoMLleqZ
         dnBLfw7SkukSgaovDXjVVaod+HR5CZvb/IfWxND0klKLZOyu3dP3n5M5STlLYsVgHXrL
         Jqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485717; x=1795090517;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8vKr7ISurIa66CKb2bSb0lWJTyTbVCUKm48dux1Buw=;
        b=MMRPS0R9EBVrhEvK6tGZhjAdubdjYfoEuX+eMDfy0nYQmg3XdR1FNXKgESneTM6MR/
         X3dKL2DclxllR1aiUadZCXvuLtWURqtl5l6+9qJgW5DKNGn1Hz+hKjeui9PulE1qEYAE
         tLdfcuExNi9hiUVfBpGwxUuvvH5GLMmFvts//4pTjjndujgG2Dmxjo1O9aZv8gYHRWpK
         OKC2RO9XHmysCbg7DKHl0FfaZITSR1plugZ8F/QyoKUtVvvsuA631QHTVrbNG5WBfMiK
         fOZ0CaaEj9DhdAlts0/HAlwWTE08oA4Io4Ql/GJCixCNfgjDWNFt56nMc01VFzv6xcXR
         Z/YA==
X-Forwarded-Encrypted: i=1; AL+hErEOwfMr2Ls8bEurydmbMQIQEHK2GUS+rgdUxYay7MVsbWG7pCwvbTG4Tg7ZRiMnrD+Bcn50Lc5+L2H8xkgP@vger.kernel.org
X-Gm-Message-State: APuU4Z8GthO7M2ico1t5MlfiJ3OCdV+nzCMZnZWByUqfNam4vYzwRH29
	0kIbBcMwZa0TPWLWnGOtLfUEvfnWN9gU2WtPPM4TMrWwiYziaw3dOO7LwrDqAu7sHpgoUdn4msa
	avFWZeTAljlW6uw==
X-Received: from wrbdz14.prod.google.com ([2002:a05:6000:e8e:b0:493:1636:8f53])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e8f:b0:4a1:f90d:6f4c with SMTP id 5b1f17b1804b1-4ba0935826dmr100851375e9.7.1794485716683;
 Thu, 12 Nov 2026 04:15:16 -0800 (PST)
Date: Thu, 12 Nov 2026 12:15:08 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112121512.1670347-1-gprocida@google.com>
Subject: [PATCH v5 0/4] clean up EXPORT_SYMBOL_RUST_GPL
From: Giuliano Procida <gprocida@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, linux-modules@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a complete rework of the previous series to switch to assembly
as suggested by Gary Guo <gary@garyguo.net> in a review comment.

The first change in this series is a miniscule safety fix that will be
obsoleted once the Nova driver Rust symbol handling is itself cleaned
up.

The second and third changes switch symbol export to assembly.

The fourth change tweaks a related test file.

Giuliano Procida (4):
  kbuild: respect skip_gendwarfksyms in cmd_gensymtypes_S
  rust: convert exports.c to assembly
  gpu: nova-core: convert nova_core_exports.c to assembly
  scripts/sbom: update rust export macro in nm parser test

 drivers/gpu/Makefile                                 | 11 ++++++-----
 .../{nova_core_exports.c => nova_core_exports.S}     |  8 +++-----
 rust/Makefile                                        |  2 +-
 rust/{exports.c => exports.S}                        | 12 +++++-------
 scripts/Makefile.build                               |  4 ++--
 scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py |  2 +-
 6 files changed, 18 insertions(+), 21 deletions(-)
 rename drivers/gpu/nova-core/{nova_core_exports.c => nova_core_exports.S} (62%)
 rename rust/{exports.c => exports.S} (72%)

-- 
2.56.0.567.gdb80ae8cd5-goog

