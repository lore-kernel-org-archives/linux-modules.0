Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613C399019
	for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393915; cv=none; b=VdSD13Xdo1c43G97SuzCA/TKcblUz01p669dPyCd2bX8vnwUrYViA/upWFJeq7ZlIaqL7yW75jbIWaZuXQ9ifFYY0V1l7g5vY+ch4ngCseOcNpYZ86kGzq1a65k0D9nBx82s53CVoXB/wf7HIwMSpEpWk8xJFPPa+rrM739oa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393915; c=relaxed/simple;
	bh=4cEsjI6qmluXc03y+Xik1t3t8Tu9eac4951kHHMMRrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/yTn8QmwP9QM00bUf+GNubAmWqmsWlpU8DMXp15JKB93oh6qTL8kV6h9HJsGUJVT6jj5d4SwwUwZ+pj82ZORSVh68XshpxEZ3enfIygqXkb1UCHkaXPcRJpbtakpbXyfbcGq45NAc0oEdd7deCdb1K31lxsmZc5oc5ylvB6bfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VuU3Vwqq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VuU3Vwqq"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc305914so6094524f8f.0
        for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768393908; x=1768998708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDpgMwk1BHGoscfxwj/PsMCXAuQ0lRGKa6CrVf+sfjA=;
        b=VuU3VwqqVwarBAP0ycg2bJeosFiePVcbzgGObILJMDGoKkegIUBKEmQrVB7e8jw3ZJ
         cKgP8xyI4evX84RK/CGS+9vzEsAkziFJf6bgOoQa+V5PNeLCQyiUB4Ty6L4XblbUmf95
         LtSQcJ48FIa9hPd8FHV4uk9t0OZyaHtbhdykq7Fjud6n6OVuPSPJWjjm+zXjrZzInviq
         dJEL1xqnt0IHGQQ1BkHj/jZqSbP2WkszLC3W4QlMWRJHjwiuItEySpFNXzC5A4985Ui4
         hs2EAJses/tsXl1QpRjk6OBPOl+x3i0H69AilTcK67mmfH1M/jBB8PXHBqNPPQDsz6/8
         YbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768393908; x=1768998708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDpgMwk1BHGoscfxwj/PsMCXAuQ0lRGKa6CrVf+sfjA=;
        b=qYG2oOqTrcO0PQJjulpJU52uxw41oYmk0IkfWKBlvfT4Lwuw2u7oSCq75+S45NIDys
         Vjj50NIab3qkQ41+A9ZgeIU08ZqXKWGw+z5aeEKUdCYRjbE13NZgGYa6MYlvpAqCZNYO
         V6D2bV3PRpyjcFqbBGCV1yeUMDmvOYOOhXKFRmHu+MhAyxCipyjxGgRu1kdXgSKsjO2G
         U8/Zs+Z3xBod2U2zTC7qDiHtWkhT1d9c/mu8MvP7+1oHvw365PkBNjTcPFuCSBCg4WSE
         BywEgdOvKCMK4cXM9ed2f5VW1ZxFvorer5ie1SKpAiJSYwPDfhOrUzguU+g/LCFx4+XW
         /bAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXa1UC6kVF5cgeuLVLBf7ghePQBHXu4hBwQWVvvgYo9fUoNc4cQT7CQXNiI1l5qtHxMrInZdec5a5Nqmo1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/om1QiZYDHmmyzrpUhlURX24zd0+GgJIOWuzGGj5idTg9HR7m
	GvKR4aghgPJ+62XxrohAuyqIzx/8/PUC2p442y+EV9J5Eix+vaAkP9QlKMHkIs/Egqs=
X-Gm-Gg: AY/fxX5hXVBOGfj0VN/StdsBZC+oRczd8kxOOvkQ86Too5p7eqfgsQcwcbxsEcEDN0s
	4mFuKKJwTvpZCGqgLcCT3lojeK9Ge+s+WL5/MlnOO4jwZEe8Vao16X5VaYfMc8uxt4PilLT0tAa
	qr/Jdn0RbYFRQZdTzAEU/kSR7qNeydlr/kFHNAArJUjjYbT6CsEF4Q/ktM+rqcel3VGQSc1rFfj
	h/pdwnxINR2Zno3JyIVsvzeBsKGXtzYDjkL1B2HIJTKkemIDHkKCkAa2YVfWukc+oWmblcWFi2a
	OOhe+SXTsUJGEt5pDae0Y7k6MCFVRVlpjGyj2JZZ1hq+2mnaBFfxcFarFy1fQCJeptfFv8Eg1zb
	dUY7OYyUZHII5UX2OcsX++3v+sUn901LdorrOCF4qQ25Ud8K4QtKLnH4B69APo8psK3Ci4NHI4/
	diwoq5Lz+bIT0gsD/ATFGZXk/zf/sKPRc=
X-Received: by 2002:a05:6000:2887:b0:430:f7ae:af3e with SMTP id ffacd0b85a97d-4342c54ac52mr2565147f8f.32.1768393907979;
        Wed, 14 Jan 2026 04:31:47 -0800 (PST)
Received: from zovi.suse.cz (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm50097772f8f.31.2026.01.14.04.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:31:47 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Improve handling of the __klp_{objects,funcs} sections in modules
Date: Wed, 14 Jan 2026 13:29:52 +0100
Message-ID: <20260114123056.2045816-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Petr Pavlu (2):
  livepatch: Fix having __klp_objects relics in non-livepatch modules
  livepatch: Free klp_{object,func}_ext data after initialization

 include/linux/livepatch.h           |  3 +++
 kernel/livepatch/core.c             | 21 +++++++++++++++++++++
 scripts/livepatch/init.c            | 17 ++++++-----------
 scripts/module.lds.S                |  9 ++-------
 tools/objtool/check.c               |  2 +-
 tools/objtool/include/objtool/klp.h | 10 +++++-----
 tools/objtool/klp-diff.c            |  2 +-
 7 files changed, 39 insertions(+), 25 deletions(-)


base-commit: f0b9d8eb98dfee8d00419aa07543bdc2c1a44fb1
-- 
2.52.0

