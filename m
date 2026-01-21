Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55813803F4
	for <linux-modules@vger.kernel.org>; Wed, 21 Jan 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984160; cv=none; b=M8/EnZ4qpV7ldvn21ZmCExlT07IDV6RkL1XrSVvlDQkKU8L+4HkA+2uLPvq2E7+MeOIHhVyBf7EHl7KMmOSKYdEmLuv0W1CqaJvVA6VxlZzauQpRKVCDruP6CXpZHVUxb9f7XaFn6aVpqdxyU8I/52IsaVAjp4TN6vq8Y+MZW/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984160; c=relaxed/simple;
	bh=M73mSeNlCdDSDOr8x2qVL/sHZIW2D8gEAgivQ+HV1Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ug6mvqf6GT6Gi1X3Qfeupad15hGRiCyIt3Dbi9KwnzEUMD42Ne3JDiGwKxKFOkqhybFzbJvT6SjlXUzA0IqfVIN5ubVGwKC5MK/Vxs8jeAm51u1cRVkqNSwDQWHjVEc+9jEELuPa7oWLQn26KHeXicp6K+eb6OZUVGl34whXZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WWBRKCkN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WWBRKCkN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee2715254so30076425e9.3
        for <linux-modules@vger.kernel.org>; Wed, 21 Jan 2026 00:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768984156; x=1769588956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rokkUlVHndrZqjIFjTr/DrX1NCRwQiWmE6h5JFa0Tgg=;
        b=WWBRKCkNM/u1zKnXQC/VQTGGG/E8uFyUz5es89LzbACxqaXpRfIGEWTG7Ms5+3J+N8
         lyMOw5/rmhm9QVKettdtNLD6MDMnzqq11g+5y869o8kaEis3Z+28Y55C65kdraBdXXAc
         SqxSWjSgqX/+pn1CwzkhnDoPTXe6IvbddhrQiRG3Vlxnp1zyWm8reRRZcNX8kLta9LWs
         tW5aaHiZldMkaNaPE0sPqIoXVMGQXidCIgE3aQFUd0VWs8EdHz4e79BqHpr/ppzAGme+
         +GTwZMsvotfNudvnwkax8I8l9vHfTKFhCmoJQvewrYdzNoj3H3e+opcpqTe+wgCgDeXw
         AdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768984156; x=1769588956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rokkUlVHndrZqjIFjTr/DrX1NCRwQiWmE6h5JFa0Tgg=;
        b=dtL18ns9YaZGbDxwXhlkpQTHapfnxrsKyjUxWxjz5EUwPiVARku/47/AcoqsEwkixC
         F7onKK4pA6JOpXtLlo8X6ZZdD+HcIbvmHOBhZnrGSltQqoh6k8DsMSK6meDmhifjgUPb
         WXMlgtGyNLXWCdHEAQSWpMSmHYN3DEGNNaZVXnyOQN0u3peDXcQBeoB/j+j7KOQQ8fWi
         KY4zqM8/K8qhx+nZTphj5yjCYph/LdhzlfudWkyfFqpJ2u1I7zhsQ1B+esdrKAKE6xNO
         y/R/ZWeyz/EqZCHK+2m3bAvHkcL4fbdwmjEjgDh0D0N+TtIIfUBXl1VeyuJD9fqnYaFd
         5lsg==
X-Forwarded-Encrypted: i=1; AJvYcCXcq3IDROgoM3NBSzNfepOcrRDRxzexqbcxBPyQVjWTRkV+0zQ918sCoqjhjsORCV7nPyaipmgAg0byd39E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SXqm/e7GzWYs9nextOENBzQuBIzCccHBNbD4TlRWx/4sIdEi
	KjO+OY1AOIkbXIzE4FCeH24WRjvVos7DBh6zck3cuGRx275NdpCVxX90c8p+iT4T6yc=
X-Gm-Gg: AZuq6aKhRBo6OqZnXTsKLm0aIDpvWmkOKKyaIg3kqDFmTl+g78Y74d8XLzPSuT4ilpn
	+0zz3k88bRKbgjJGOj1uOxE4RF4445erEohtzkCXXQKpwIzj+0gbmdxTmU9yL4eQa1y3aetpEUw
	TJawjaGIGgIOkCfuwEL+WVDMiIqbN6Zcd+LlOSqUC/evrAeNcacV37Xb+L+xpvMYGVO2z/tJxJZ
	FpnUbTNHczhVj9PF9vrUJ02Me0ErCQaLQ7n7HTaIUt4lF9WptRs73BYG2AVhIBDv+fV4NWIY43E
	XI5l1zY2rA2/A3k0Y59lrmthKMO9fN8zZ6fRDLOBp0x9skQst9d673Uo7Dukib0b1N1id2yhaHt
	KSRlWsBfNoSOjgLHQ+8lguRwjW8chUuwwKYavuht+nBrBbIBWeSTd87yNiPo660ucADBd8Fz/mu
	PJcVjD9QuHVVO4xGOmR4tY+spV41PgG4c=
X-Received: by 2002:a05:600c:a03:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-480412ed37emr48490635e9.6.1768984155839;
        Wed, 21 Jan 2026 00:29:15 -0800 (PST)
Received: from zovi.suse.cz (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm441635355e9.15.2026.01.21.00.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 00:29:15 -0800 (PST)
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
Subject: [PATCH v2 0/2] Improve handling of the __klp_{objects,funcs} sections in modules
Date: Wed, 21 Jan 2026 09:28:15 +0100
Message-ID: <20260121082842.3050453-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1 [1]:
- Generalize the helper function that locates __klp_objects in a module
  to allow it to find objects in other sections as well.

[1] https://lore.kernel.org/linux-modules/20260114123056.2045816-1-petr.pavlu@suse.com/

Petr Pavlu (2):
  livepatch: Fix having __klp_objects relics in non-livepatch modules
  livepatch: Free klp_{object,func}_ext data after initialization

 include/linux/livepatch.h           |  3 +++
 kernel/livepatch/core.c             | 20 ++++++++++++++++++++
 scripts/livepatch/init.c            | 18 +++++++-----------
 scripts/module.lds.S                |  9 ++-------
 tools/objtool/check.c               |  2 +-
 tools/objtool/include/objtool/klp.h | 10 +++++-----
 tools/objtool/klp-diff.c            |  2 +-
 7 files changed, 39 insertions(+), 25 deletions(-)


base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.52.0

