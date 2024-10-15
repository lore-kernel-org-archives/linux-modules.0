Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221541D63EA
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034373; cv=none; b=LHYoLNCv4YuaTqxpm7vfFad7R0F1S1HFs6slFX2V8k17tzzCIkZigsEKdwrbMD3KCD4x05xOjOzOiDsM8b4ag1Slq22cJVNb7Iyp9t0Av1wY8j0dUF392d2+ykttlnxwsF1+Qbxmgz/48AM7CCPGb+6+j7WTgEKpCAC1fM7iXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034373; c=relaxed/simple;
	bh=+F2VbNZf1bhZ2UaA03ZPHWNIFVcKxoyVzX20irGYaCE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hTcK7qG4QzBHtmk3oPcbWG6XHaz8EQDffbhAFp/jM54b/2h30pBhZ33S1fyOrCvxXBD9AC70j4R0yWSZ/4WxjLktvCNlcon+nVzkTKs/HSr+it4UQPmP1ADBIVgVpVMxO5sr3MJZY5JoUeipgvfw2RjPm7NtPox3V1yDNjR8iWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMAVXh/i; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMAVXh/i"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e000d68bb1so4277787b3.1
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034370; x=1729639170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mrJp4iFzpg7dOEUx5ArGmKTsHqr2X7jfl/sNyFyGR+8=;
        b=RMAVXh/i+YxZUiL1R8LbIDXsHEKlAJ/NHlsL1aDYu9x+gmO4FZazS36eCS3efXDkgU
         M/wv5Q2AXyzyMyaMqIyYnMi/YjWhlFo2UdGLIw9wnb1Ue6kHlrzuq3qEzySB/RRxeha6
         762HKR5PMGmkPVBj2m7suAC7WyBAa7kw7b2CPRPk6U+QoHfZMcHsmdXhlTIg8CI+9Awi
         Ngvcy+tClp4DbCU87qTwclBNgCyeSNr1fAEBzPyApkMtQiGRRpRTICINlm6TFWh87iAP
         HRQ6NbWhcvuScilDW4IbaokzusUI39jC+SuU3oYqGPO7e43znALB2tG9RiQkZHnENqMB
         geNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034370; x=1729639170;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mrJp4iFzpg7dOEUx5ArGmKTsHqr2X7jfl/sNyFyGR+8=;
        b=VLHGzVY2tVwNvtEMVko85G0Lsj8MCd4zD+bybExjnZpWgwoHyBDNkT6lAoofjA2XTC
         5/m7G0M09m20UMNmfpddO2BWfNrBpvfBHffCE7MSY80aJqW1p5I99q/L70RQTftXUMQ8
         vO3BqPgyoyHCak1JdibxyIjqiaf9CVgkp3Z0rGYv8gCQAPLE0lOgRtGnzby7nTrKakWg
         y143hblGZ1EN8aLIU6dKNHBiWeF9scd6ZsMcpI5s/sLVrsMR+Eq/Rl/OnMBC8Z3gAcNx
         Gfl7/qZSMRk808tu/ZPx9NXwLl5IEmaG0wo39NaOXK81o/NjGF6fphRsI+/IeTUFrsWb
         csXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUznANAzz4U7hSstsZpTSFJYC9tuyIwj7dVxVZThml1NzFEahv994Rz5bRqZCo2k+mm2baBNy4vJ5s+68SS@vger.kernel.org
X-Gm-Message-State: AOJu0YxYuQK/1jdTSLcf9Rt0+u0HS2pJsR0EdB0TlffE2kwrDzeKwwjV
	adPVErQAqZlaNutvtP5ElVkZ/1HbQUCNJSsXq37gVk+q4hKoLN2rbVPbraGlrEWR3wyqOxft2be
	2GIwaaw==
X-Google-Smtp-Source: AGHT+IGjGandx9utSrvuA6uN/UlbhV0NFNsrW9jxyZLY7Y/xUho6mObXEYFljDf/DSG5duM/8SOImAxH4q50
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:7005:b0:6d3:e7e6:8460 with SMTP
 id 00721157ae682-6e3d35ac029mr391157b3.1.1729034370036; Tue, 15 Oct 2024
 16:19:30 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:18:55 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231925.3854230-1-mmaurer@google.com>
Subject: [PATCH v6 0/5] Extended MODVERSIONS Support
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, samitolvanen@google.com, 
	Matthew Maurer <mmaurer@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

This patch series is intended for use alongside the Implement
MODVERSIONS for RUST [1] series as a replacement for the symbol name
hashing approach used there to enable RUST and MODVERSIONS at the same
time.

Elsewhere, we've seen a desire for long symbol name support for LTO
symbol names [2], and the previous series came up [3] as a possible
solution rather than hashing, which some have objected [4] to.

This series adds a MODVERSIONS format which uses a section per column.
This avoids userspace tools breaking if we need to make a similar change
to the format in the future - we would do so by adding a new section,
rather than editing the struct definition. In the new format, the name
section is formatted as a concatenated sequence of NUL-terminated
strings, which allows for arbitrary length names.

Emitting the extended format is guarded by CONFIG_EXTENDED_MODVERSIONS,
but the kernel always knows how to validate both the original and
extended formats.

If you are testing this patch alongside RUST by manually removing the
!MODVERSIONS restriction (this series doesn't remove it, because the
CRCs don't mean what we'd want them to yet, we need the DWARF patch for
that) and have kernel hardening enabled, you may need the CPU
Mitigations [5] series. Without it, the foo.mod.o file produced by the
C compiler will reference __x86_return_thunk, but foo.o will not.
This means that the version table will not contain a version for
__x86_return_thunk, but foo.ko will reference it, which will result
in a version check failure.

This series depends upon the module verification refactor patches [6]
that were split off of v5.

[1] https://lore.kernel.org/all/20240617175818.58219-17-samitolvanen@google.com/
[2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org/
[3] https://lore.kernel.org/lkml/ZoxbEEsK40ASi1cY@bombadil.infradead.org/
[4] https://lore.kernel.org/lkml/0b2697fd-7ab4-469f-83a6-ec9ebc701ba0@suse.com/
[5] https://lore.kernel.org/all/20240725183325.122827-1-ojeda@kernel.org/
[6] https://lore.kernel.org/linux-modules/20241015231651.3851138-1-mmaurer@google.com/T/#t

Changes in v6:
- Splits verification refactor Luis requested out to a separate change
- Clarifies commits around export_report.pl repairs
- Add CONFIG_EXTENDED_MODVERSIONS to control whether extended
  information is included in the module, per Luis's request.

v5: https://lore.kernel.org/all/20240925233854.90072-1-mmaurer@google.com/
- Addresses Sami's comments from v3 that I missed in v4 (missing early
  return, extra parens)

v4: https://lore.kernel.org/asahi/20240924212024.540574-1-mmaurer@google.com/
- Fix incorrect dot munging in PPC

v3: https://lore.kernel.org/lkml/87le0w2hop.fsf@mail.lhotse/T/
- Split up the module verification refactor into smaller patches, per
  Greg K-H's suggestion.

v2: https://lore.kernel.org/all/20231118025748.2778044-1-mmaurer@google.com/
- Add loading/verification refactor before modifying, per Luis's request

v1: https://lore.kernel.org/rust-for-linux/20231115185858.2110875-1-mmaurer@google.com/ 


Matthew Maurer (5):
  export_report: Rehabilitate script
  modules: Support extended MODVERSIONS info
  export_report: Tolerate additional `.mod.c` content
  modpost: Produce extended MODVERSIONS information
  export_report: Use new version info format

 arch/powerpc/kernel/module_64.c | 23 ++++++++-
 kernel/module/Kconfig           |  8 +++
 kernel/module/internal.h        | 11 ++++
 kernel/module/main.c            | 92 ++++++++++++++++++++++++++++++---
 kernel/module/version.c         | 45 ++++++++++++++++
 scripts/export_report.pl        | 17 +++---
 scripts/mod/modpost.c           | 41 +++++++++++++++
 7 files changed, 220 insertions(+), 17 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog

