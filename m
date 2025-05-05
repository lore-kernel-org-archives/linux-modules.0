Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44A1C1F12
	for <linux-modules@vger.kernel.org>; Mon,  5 May 2025 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480249; cv=none; b=joDGDxA6Do1FEtKuCzuIBufaYurJm8HdcN3YXh8vHxYFQtsQ8Jbm9ELyTi02i+IQsHOcl/0OYZcyjUuSV12d7YfpAtskohm0hDVmRAu1rp2rvkljOi2+KFh4U7Sc6H4MoqwQCdNX3yJSPNb0yNqCMYFUIxoaVg0fZQ/LLaSLxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480249; c=relaxed/simple;
	bh=Pu+rvPKMvPwl+p+ShOL+ySOcF9CZrqg5DPqa/1mEDiA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K063awkg86xOvXmCkyZ7IlHrV84/tEMWFjBYRQ2MDv5LW93hoGSA4KVYV57EE9hQFAKM1IxFix8M3kKbCpCWP10M95+b6pxtHSM2DddLmNssyT/6AAq065TusMEmeOo4c8UR6izxf7+M8ngeGBNfeKUrIB4degxFoZZI0jxx9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOE5gSra; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOE5gSra"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242f3fd213so45208825ad.1
        for <linux-modules@vger.kernel.org>; Mon, 05 May 2025 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746480246; x=1747085046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2YMXEvinpJM5Wf/VxLLIFrvMmVuNow6c81RXLDoZqD4=;
        b=uOE5gSraOfhdnDmmIJdH/4CGP9WaCT6r/sKh1LCwqXpumpzd+MaC6VCfGC2d8yU4g4
         JYnURSe0IGxfEo1QYYkUo86XaNhZiewkUxkBX4LdJ6KB6DI/9CeA0gsQeX4dhBWHw/pR
         JwKncbVLoh7xlEbSMpJcEXzj+Qr0SVLJlSiSDOdqfoasrzI/OEHGnoBWbSeRl6ONY4Z1
         6k0WmEmZw5oSyo2wL3hGNzd5n7JY0BrbTq9T+H6BpqF0mdxjZ6T8zQJgEsbftNFRif3w
         7RJi0LnSdNSJeuNRV/BNVUzM0F09OHF1VMUyLa7lDfZDf/fxUf1TnQ0TPe062HkhGC6r
         vE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746480246; x=1747085046;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YMXEvinpJM5Wf/VxLLIFrvMmVuNow6c81RXLDoZqD4=;
        b=GFVWQoCGSwRK5/Cw56m7F2B6h0ACLqQ3qn23jIrWdGJF6fhcOP/HJBrga7QyahjQAS
         gOp/L3O23QBSUERfmP5+X4cGskJ16QVhY8P8jWWQ85m4Q9hLnbSIouoC66b9SuIEyH//
         Yf4c1kXZ/rw1Fv2F6eqxOzewi66YefTvrPte5zMnW678uxTXBI/J6NJQrErgIzKbzFy2
         E9IkwSKarg8mOtbP+e8w0jwaSVV9g2CluLWHDcAWkv9knTG+oNh+4cxRzBiqhftealhs
         HaAhvGOfRepyfCCqckFlVQQ8feLK4s8RpFaMt3sA9vAgxMB7BmIVCfZGTVeFsRldGl3e
         L4Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVq7JMVWMAWwCe0Lls/HtlLNEtLziiFI5AlPr6n/cpxq1tZe7fCjtfl904eFn8yUVAFKkP+7ybu4wBi/UHI@vger.kernel.org
X-Gm-Message-State: AOJu0YzckWPzI9JILfPO8o45baJOzgEotbBl61s0xAZnkLMCJEm//fXo
	8WZ7N1DN/32TQAVaMCOquR4R/gT188hlQswLOer8IzehIFlrKxoYAk6aNIzG3IqvzDB4ycDnDFe
	D75IDjG56dR02gEUE98q+MwWNUw==
X-Google-Smtp-Source: AGHT+IEPt/QXAWG9e0Z2HJVijs5j2ABqhPKq++Dy7TFxrvunz2ipEhowr6Pt8rjWyt3MN4cGNlob8TPM79Xt9QUf+HY=
X-Received: from plpn6.prod.google.com ([2002:a17:902:9686:b0:225:e051:fe46])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ecb:b0:224:18bb:44c2 with SMTP id d9443c01a7336-22e328b4696mr11032685ad.6.1746480246476;
 Mon, 05 May 2025 14:24:06 -0700 (PDT)
Date: Mon,  5 May 2025 21:24:02 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=samitolvanen@google.com;
 h=from:subject; bh=Pu+rvPKMvPwl+p+ShOL+ySOcF9CZrqg5DPqa/1mEDiA=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBmSOoXneDPO/0hx9lndFai1+Jo2z4Ijb2eV2thWTX6bW
 BbQvkOno5SFQYyDQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAExEZDEjwyTZm88lZvf8ebf5
 hNjCbRHL2cuO7VWeq1122yxA8Yf+lN8M/5TXRSlErbVfrfB37/pv3Bwv72z4mH9S467Q1NpnSh9 COdgB
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505212401.3379699-6-samitolvanen@google.com>
Subject: [PATCH v2 0/4] gendwarfksyms: Add more kABI rules
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

While looking deeper into the genksyms hacks that have been
needed during Android's 5.10 and 5.15 GKI lifecycles so far,
we found a few instances that are not covered by the existing
gendwarfksyms kABI stability rules. The first case involved
appending new members to a partially opaque data structure, and
the second case completely changing opaque types due to a large
backport that was necessary for both stability and security.

These patches add rules that allow distribution maintainers
to deal with structure size changes, and as a last resort, to
completely override a type string used for version calculation.

Sami

---
v2:
- Cleaned up type string parsing based on Petr's feedback.

v1: https://lore.kernel.org/r/20250430214049.2658716-6-samitolvanen@google.com/

---

Sami Tolvanen (4):
  gendwarfksyms: Clean up kABI rule look-ups
  gendwarfksyms: Add a kABI rule to override byte_size attributes
  gendwarfksyms: Add a kABI rule to override type strings
  Documentation/kbuild: Add new gendwarfksyms kABI rules

 Documentation/kbuild/gendwarfksyms.rst   | 103 ++++++++++++++--
 scripts/gendwarfksyms/dwarf.c            |  14 ++-
 scripts/gendwarfksyms/examples/kabi.h    |  21 +++-
 scripts/gendwarfksyms/examples/kabi_ex.c |   7 ++
 scripts/gendwarfksyms/examples/kabi_ex.h | 101 +++++++++++++++-
 scripts/gendwarfksyms/gendwarfksyms.h    |   2 +
 scripts/gendwarfksyms/kabi.c             | 143 ++++++++++++++---------
 scripts/gendwarfksyms/types.c            | 140 +++++++++++++++++++---
 8 files changed, 451 insertions(+), 80 deletions(-)


base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.49.0.967.g6a0df3ecc3-goog

