Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB528C027
	for <linux-modules@vger.kernel.org>; Wed,  7 May 2025 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746659652; cv=none; b=McqHJDljZ4AiUQrzAV6NZVi0ZZ9R31795usEvuyCBdg9JU8Nx8wZkWsVIYhPL/E7sIK/KTg615rbmAZK/em7HYNqVeRH6/+/udHHTENN6Cf65LK4IPJRNCPd63XcyrRQqRB7xdmjHiGhsYD2WuyogT7557Ww8eBk1oU9d1neuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746659652; c=relaxed/simple;
	bh=HzW110DidE0q9odbugPFCNeNJcGViYPf4XhsZU8Eg7M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fN3NViHT1XLIafUdeFiTvzBAH380K109SlRh2MjIKudPdEOuBxvh9avgCGyADE0PR4nSX6EA7kRXZZWLD9cdTWNXms8rhB85Upj4KpXLf2faNCm3Fy56XJ/jcjnaObl0xDGLRPvpJltBI3TOnYHjszkvq0U4bGDXH6hGfs2MEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tbav+TuQ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tbav+TuQ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd27d51fso320516b3a.2
        for <linux-modules@vger.kernel.org>; Wed, 07 May 2025 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746659650; x=1747264450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqiMgQ71QQLoB/rsJPzh4QUTzLVQw3NwrkPuAkl+72E=;
        b=Tbav+TuQe2ayLlZ7h3cCyoz/I4Dmjpn6TXycnge3F6lE+SIA0sQXCiNmST5DVwpun/
         +Z/PJHwhTpcZ3z8yfrFlU/iktEC5RrB8j8jnkpAr+VnagZ7Lk8Dq+s73SHDIK2bVJ+x7
         jBzvJD9eHb67Y7NvfxNpyDWMsiPdDMak2UeDIcLZFYapqTL4AtHkLwwANMNKl8ttxZ+z
         87gExwOHdprrZA/+Pt/2WGIiH0EASK9jndVcsutpCfP9aKwt/zjHX96LhI9BeVtkJezP
         6YM1wPSEMzNNUrxfaL5C+1rw5jyxAEhKEBi6DwwvZP7F33AolqZkluDw1L18pEZg25T8
         L12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746659650; x=1747264450;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqiMgQ71QQLoB/rsJPzh4QUTzLVQw3NwrkPuAkl+72E=;
        b=qNYVUvzOdDWOJf1lcshGD6krbC1c2KGk9Rc5VnC8NFvflphqimiljOr7LNGYjMAsX4
         UYl3SzvjzmAE+BwQgEznR7FRbUgINraFDYl4bL6BNMndmWw3/2h0W8BGPWVVtuDRObG/
         Plbj7SEc+rY78SuV9r60EpF2aYGlwPq77zjCVOdQqD/jTIdY98Y0el/25RW7V26BzsHz
         9zBt/SYocUztPr+y0sD+W+SPydP/ZW7NkB76AjpQEnb5J8NM2Ck2uyZwuJkK/811qNhx
         slh3+wAjS2m0FV4NuyYg2RbPOFwp4XI1MkSKJdJfEnbgspBWe8pE9my4MH09p/jK4ui5
         eIVw==
X-Forwarded-Encrypted: i=1; AJvYcCV8DPRkEjeNW84d2rf4ytbEB0N+j7LYINJI9rPSS4v/T0Ju5Wt4uyNTu55xECGkvwY6kQomvqYiqNteQuHY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2SLEBpHQfFP9I1TRP1YfgHTQboijsts3mgB9wn1XjbP9Dy8l/
	3+FWcUyyxLyS/voE0FhjUwh+O4B4y1ynyQrQELoaPjbQQ0FbjQyVohMd1ekU5vnaq3U27+6wM0J
	SpCI1+V6CgUuSPZ7uga4itAIQzQ==
X-Google-Smtp-Source: AGHT+IE5w9gyOvZa0TkPolWInYeuHi8tBwzNliv+OPal777LWG0jHAD3kn/yNXRmhJhmW69s8987op1exG0N1kXygcY=
X-Received: from pfht21.prod.google.com ([2002:a62:ea15:0:b0:730:7e2d:df69])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:174d:b0:1fe:5921:44f2 with SMTP id adf61e73a8af0-2159af89b5cmr1396801637.20.1746659649702;
 Wed, 07 May 2025 16:14:09 -0700 (PDT)
Date: Wed,  7 May 2025 23:14:04 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; i=samitolvanen@google.com;
 h=from:subject; bh=HzW110DidE0q9odbugPFCNeNJcGViYPf4XhsZU8Eg7M=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBnSL63fn3gVtPfQ/J9L784M96p5tbRVWobtpnrk0p7+z
 7uELVwFOkpZGMQ4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBEPt1l+M3iKrvM3nNltKJW
 9xPdW9Nu83ZW31sz1+1Do9zy2Vs4YhYy/OEKzeCbuOaygsH1LTxzFGwP+f9LkeoW4ezS8vq4wkk /lx8A
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250507231403.377725-7-samitolvanen@google.com>
Subject: [PATCH v3 0/5] gendwarfksyms: Add more kABI rules
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

v3:
- Added a patch to drop documentation section numbers based
  on Masahiro's suggestion.

v2: https://lore.kernel.org/r/20250505212401.3379699-6-samitolvanen@google.com/
- Cleaned up type string parsing based on Petr's feedback.

v1: https://lore.kernel.org/r/20250430214049.2658716-6-samitolvanen@google.com/

---

Sami Tolvanen (5):
  gendwarfksyms: Clean up kABI rule look-ups
  gendwarfksyms: Add a kABI rule to override byte_size attributes
  gendwarfksyms: Add a kABI rule to override type strings
  Documentation/kbuild: Drop section numbers
  Documentation/kbuild: Add new gendwarfksyms kABI rules

 Documentation/kbuild/gendwarfksyms.rst   | 141 +++++++++++++++++-----
 scripts/gendwarfksyms/dwarf.c            |  14 ++-
 scripts/gendwarfksyms/examples/kabi.h    |  21 +++-
 scripts/gendwarfksyms/examples/kabi_ex.c |   7 ++
 scripts/gendwarfksyms/examples/kabi_ex.h | 101 +++++++++++++++-
 scripts/gendwarfksyms/gendwarfksyms.h    |   2 +
 scripts/gendwarfksyms/kabi.c             | 143 ++++++++++++++---------
 scripts/gendwarfksyms/types.c            | 140 +++++++++++++++++++---
 8 files changed, 470 insertions(+), 99 deletions(-)


base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.49.0.987.g0cc8ee98dc-goog

