Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4D41A54B
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007499; cv=none; b=VZ2+i4n1OqwSnAoJcZEPnnbwyzh1t1RLNBZ9MtpiiDWmMXcCiD8AcYj5hgSMB6Jn/GWnd9UwqteOeZ3dpsXJW7zCea+0OEOM3fKNOIuypNn+y/STF/ZazcWxBS/2xK+iuaT+nMzj/UYQqVNBu1F/7nN70azsZ4JRSNZdb4ukoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007499; c=relaxed/simple;
	bh=wau/1WIhil7ujIFDcaCDVHnYKSig4PeZPXDhG0IZ0Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tPLizFfUj6d3PbcBwO6JVhijqs3g71R/gv2k8aPK7ZC1aNrQeU8O0/DICh0OJUEdyOWwlfBFLRXKbdypjjt0DAPxxnpUMmHpoSa/BGkgG+j9So1hIXczu398h5Wb/SuP8EOleN8UzktWY5VLcCBMrwuLiDzqtASGEvWnu+9eEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SXvZmTbk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SXvZmTbk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495437bb891so6544585e9.1
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786007496; x=1786612296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/7mnnGV5KwgYQKLasYjgSyiYaGHDqpreUuqUW9NAfOE=;
        b=SXvZmTbkgzBJ6oJEuNR0ljqW2quvnTgR0zwjTQOYsMTuOtPc1O/uIuUtgjoFHQBNc7
         kXzxJN63W20k7gPKdZ+Iddj18KRDP6f6gJTCvP5eyzgRLttSW6HdbZBkMSylfKXzB7o8
         hKoqsF0cUGnmvt7Hqb0sQR1uQP8GaONjkJyAHx2QNl62+gjsLeIezIv58HC9LYpTLvFA
         +1WRlRu++JBQCmAjITPdxf9jyRkCffa4GxDszc1b801LRZfBofaHefXQBIhMWzCDjLVb
         j9Fa2tYLuWvIsg9NLcnA0OTOZqOnVgQe/VZB5jAwldxHhjc+UxsICjkNW2O3RUeqLE6B
         hXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007496; x=1786612296;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/7mnnGV5KwgYQKLasYjgSyiYaGHDqpreUuqUW9NAfOE=;
        b=YSkzbJ0hCMJ9ZF3s1Rw8ghArJn5BtdrWqFEg/lbLAIPDQMcrH5l8cR5fKV7he8qSkR
         XI2NdXMo44BzZ8CkBOTGEyWH9swY24H6ZveFHbmtqDgdBnvHpJyZ+9MUFv73ToEO55Bp
         NNiwzeYB482xpsfGpIooIKltaYsDfL8StNmNKiV3J8tFj9IaUtPTPzdALxr/kI7FU8bP
         Ut2ZYjamYds346kNVFULrO6mZ15q7gG3s4tBneSoxqn3XtFC78O4YGnmWJjcTZaKy72T
         h6nVV4VC7VHy3bGT6x0JpvMT811ellydfWKPhdZPfrdjN2fWot4v0vI8kiJzMVQb50yi
         XmNw==
X-Forwarded-Encrypted: i=1; AHgh+Rok0ZtAmfQ0+41/XhMxQqymV2ThrR8qhR59N6y0MK+yr/tB+VStjCw+ZVozWL7CNq7a7LrA1Hs2Y9UhV5zy@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvnEbnG1lFy6zB1kjuLAYMW88TmT9DiKeQUyWb741zTexSoNi
	IKRlLFrsiXT5nCrIOEuI7NTWvkJlTN32vl9OphCol3/BTTFukDwewa+/RtgbRc1f+10=
X-Gm-Gg: AR+sD10lFO2sCOIGfYUq+lyFb4SAudjh2qRa3aBaCp5OkFlticDOTjPxWisqX5hO5aP
	UJTOduLdsuqcAiiyizToVKCWrwTJ4IeI6BWpa+tV9vnMC/35LEVPVYpIIGvk77pesuHhb8kS7za
	iQAsNEAkQxouWOCgi2oBjvAg634d/C4jnT+Gj9icg8pozHLzcsXdB1DM+uAu7LFL68Eg1b67GpX
	mGzDB7fiGn/8M/j2Kqb3g/8JHLXGCv8Bse5psLKZhFoVCYLeu6Pd3bGHpllvwsuXEuxpKqIpINr
	nfJ1rJO4Cp5msroczARnl88lNXL5xKOPBZlyEvi7BGC/t4RYo8z0iWPSJ8aG2xvHmMiA/aZjnH7
	h3VoWtBtAiPM9wUmQyG0ll5IkWOfe2BxPwh8Z+XCHAJx7DedUIoLecyjn1PGtgWEMZf/a9R5LD4
	88OWO7UiWK0d2oXJiuIEgsRP8ykB8/To6swBNrFgxbMCG+g9aBlEbMeUGs
X-Received: by 2002:a05:600c:a48:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-499553f4c4cmr35914785e9.8.1786007495617;
        Thu, 06 Aug 2026 02:11:35 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4c32e0sm93157095e9.0.2026.08.06.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:11:35 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] module/dups: Fix a use-after-free and improve the code
Date: Thu,  6 Aug 2026 11:10:14 +0200
Message-ID: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260722-module-stats-rcu-ff0dfc986be6
Content-Transfer-Encoding: 8bit

Simplify how the kmod dups code informs duplicate requests about the
result, fix a potential use-after-free when waiting on a duplicate request,
and make several general improvements to the code.

Note that the use-after-free fix depends on the code simplification
implemented in the first patch.

---
Changes in v3:
- Add received Reviewed-by tags.
- Rebase the series on modules-next.
- Link to v2: https://patch.msgid.link/20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com

Changes in v2:
- Fix handling of concurrent request_module_nowait() and request_module()
  calls.
- Avoid unnecessary kmod_dup_req allocations.
- Avoid mixing goto with scope-based cleanup.
- Link to v1: https://patch.msgid.link/20260720121621.750661-1-petr.pavlu@suse.com

---
Petr Pavlu (6):
      module/dups: Inform duplicate requests about the result directly
      module/dups: Fix use-after-free in kmod_dup_req lifetime handling
      module/dups: Avoid unnecessary kmod_dup_req allocations
      module/dups: Use scope-based cleanup helpers
      module/dups: Use strcmp() to compare module names
      module/dups: Clean up includes

 kernel/module/dups.c | 169 +++++++++++++++++++++++----------------------------
 1 file changed, 77 insertions(+), 92 deletions(-)
---
base-commit: 2600d43b235b029d0ba4f2d3cc71e2137114fde3
change-id: 20260722-module-stats-rcu-ff0dfc986be6
