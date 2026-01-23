Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C342C0F79
	for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164126; cv=none; b=Nvm2o5FRPbh5emfARiFfch0/xveiTPph0UQLp/nsBrSaAR8kbIB9i5OMUpCEdlyWExOcbhbytpBz18o/FpIwrGKKtkJtCzYzn9wiWCEQE8lDFQirmgzr1CcYYOfzerz6zpN6WXNAFblsXom15Vu0ZxeEJ4Me//R2RRLeHi/+nYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164126; c=relaxed/simple;
	bh=vZ1mu8tSLKnZvZCLHWhAzIgA8g1lboSmvVDlNeb88nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqsfRAUZJvK0OJzGbkz1xNMyZWPfs4IVL6DqZEYwP5jwNl2Wo7uoWadrxFo9S9nsAiwLkML9y1eu+nvoUYs0FJVocBQ8/6Z58YsvS+cp4F4riUk7WnFepodnVSzv0TKHYhc/rR60THkQKGEF267A4D8lr8Fm5VCxUYMlfJ1xD/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DfgiVAmQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DfgiVAmQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so17469055e9.0
        for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 02:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769164122; x=1769768922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tCADJuO9Wbmf06FkgoP6KGJu7f/7b8t88gQaAJJ56KY=;
        b=DfgiVAmQminUUCfEvpsFyzML3DK4bjplmr4NhZ8cIxAeFR9WAU8/m7k0qQtOhSjgfu
         HFwWmAwUMiLVaqfmVHWm7YDMlglJNKy6bh1yfM9Vx2VBSsLp2mqkyck6zBvMPgql07Pg
         eD0r+rXREcIbhPUd6JfRy/OMFd+0ReUuYgKa9ALSx3WUEnjJM2dkTYgYQfF9rpA8XI/Y
         KVLb2jqRtfmF0V5rWvpHi5F7Atax6T6SqzsOuHPDrsRdfoEs9r+5XZcFGyCkcevm18M5
         REFMeHji11/pRGuVm032f/Av/q0dFoCLuFhE74YxasPt5mYcfhjBJx9vnrTNR6CtPRzH
         81Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769164122; x=1769768922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCADJuO9Wbmf06FkgoP6KGJu7f/7b8t88gQaAJJ56KY=;
        b=Sg+4wriwMx6BpNRo71MFn6rOQAeZ+02y9hYEJiXiAR/qdkaD7gggzLKuc99emQjQzM
         BFR+Ts5ZSSz1GI1s5b3o/fPXsmqkIRVHHapB8wbEmdVlgi2yD5gQTBfjGvA+KWSvVJMa
         WlHCTnk/feV/HMnyuyKag+bRduLy0tBhQRVRW+niMMAAI7/X/XPMQKz/JTCaMLnItIB6
         gaoIxWe/ijo9MARsvs6zlmxn65pZCuzLx7SdSvMLjO1XtD0WnUlKSNNh/bCnJzUzRvIG
         uiUfYGBeNt2qsYOUlX6IWoZVvsMssPB4UkR9FM29lfeNVr7jTq4PtTvQeYF8Oq1mQUdY
         53kA==
X-Forwarded-Encrypted: i=1; AJvYcCUuvEtu0JVWtm6BoiBlgiuuTyitdY6+V4o945obqmxD3KpKYXYv8sP8n3b9DurAGD9xtvTZe0xLvnRQEsmK@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxItK/G3I0WxkwQKjwqxluuWrOwCRrrn91Cgl6WoSIkLlGhqK
	gvxb0FDl3Hpy9sH5eYbSKc1RiDxGXROPXxHNSCdDIkJdnIhQN3SCPjya3uaNqhyyFY0=
X-Gm-Gg: AZuq6aIR6tCqLFGlmoojyEIvOEZFbbSGvi84xkeF4OtMEGUVEgl7Nen0omkhvHyljvF
	+xi2nj87dQjI2KUnMCRGrJFei68YdwmkM78vWEiaiUqEvfi1YWZUB2LKuld8cdgNLoP0FhqEZcR
	am0m2R8A2wz/eHQPPzam+eMLywMf0FPdXYIOZFQgGqi9XUverVwZQhVVARzb10YgYa/7HHj0mE+
	uK+lBxVHo0S0BZGsr75rFjNNQhi4DHPYzkGoTKkdt7oeCyMFuL17z7+cFuJPnkE7y049yFu+rDT
	9fjDxwhp5rvzxXzEXX/yH6IrAzBHEBOdTVDIFuT5rV7zBolInOiizSmCnkz0DsfVVYxVPE60ZJC
	YtwCHUOpO2U1A8fZaUUnFjTSRht34IXuATfwlTNDt3M4/s9VB0DRB5XFwbW/UbgBehYpprdiCnV
	yHxGDBKODsEPcMJlq5s3HU80wh6HICspfH2JlmOdCUDQ==
X-Received: by 2002:a05:600c:6994:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4804d2b1704mr36414875e9.3.1769164122581;
        Fri, 23 Jan 2026 02:28:42 -0800 (PST)
Received: from zovi.suse.cz (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470474cbsm128920065e9.8.2026.01.23.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 02:28:42 -0800 (PST)
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
Subject: [PATCH v3 0/2] Improve handling of the __klp_{objects,funcs} sections in modules
Date: Fri, 23 Jan 2026 11:26:55 +0100
Message-ID: <20260123102825.3521961-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2 [1]:
- Generalize the helper function that locates __klp_objects in a module
  to allow it to find any data in other sections as well.

Changes since v1 [2]:
- Generalize the helper function that locates __klp_objects in a module
  to allow it to find objects in other sections as well.

[1] https://lore.kernel.org/linux-modules/20260121082842.3050453-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/linux-modules/20260114123056.2045816-1-petr.pavlu@suse.com/

Petr Pavlu (2):
  livepatch: Fix having __klp_objects relics in non-livepatch modules
  livepatch: Free klp_{object,func}_ext data after initialization

 include/linux/livepatch.h           |  3 +++
 kernel/livepatch/core.c             | 19 +++++++++++++++++++
 scripts/livepatch/init.c            | 20 +++++++++-----------
 scripts/module.lds.S                |  9 ++-------
 tools/objtool/check.c               |  2 +-
 tools/objtool/include/objtool/klp.h | 10 +++++-----
 tools/objtool/klp-diff.c            |  2 +-
 7 files changed, 40 insertions(+), 25 deletions(-)


base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.52.0

