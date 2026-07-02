Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C135677B
	for <linux-modules@vger.kernel.org>; Thu,  2 Jul 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010485; cv=none; b=V3RSjIAm8Zh5VilSl26enPPdEw5uVQFh0966Jd2R6nYJnxXIygYC58b63xpnITXJhnKy83CtSwym4NmS77bm9TIb1azEnBJc/L1ujfIXE2/J4eNN7xoCAc2VIAOvRdr9OxTZ+n9oyv74k1VwoE/UPFSCo7NvCGf4O9d5noOiUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010485; c=relaxed/simple;
	bh=VSikVomK4BH1ns73BMbLgc83yqlpizqOwQQtNSd/MAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tw7cdmqmW9EFbvCg99I667D4Nif5wNaPls9OTvmGuBI1ZYKSkeTaNkMHvi3Gm42pvAX+nVa4W4gZuXOoVI9hF7GW+YpekpSNkRA6KzhNh54dakKROlH7bBxI53cHhbU25NsBAaoeh5G0io+KcBuAnQeb45+rDRLcoV6251JoH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oa11QN7p; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oa11QN7p"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48f0e5e6698so1267228b6e.1
        for <linux-modules@vger.kernel.org>; Thu, 02 Jul 2026 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010479; x=1783615279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxiUl+/bAdRLvWtuMhB2y4s8JQp74XEt9Vmqk681vy8=;
        b=oa11QN7penuF+rkO0mdXA58/7989HC9ZMEVBlhp0I+7uEzaE3afAMSi4hJ9UNmtG9j
         8wg/5hgqMxEAthtZS6+tutZQ+Qx0pFCKV86ORTR1RcjguyC4uPpBvR5+JJPVh4J3GvU1
         0jW5SMRU9OAnOZDVIBx/klVpyZXhQmQg4syi1882EpSsBByRIKpL3gSfFPLE1K+yBfP+
         e7oi9imed0MsLIjgb+4vimrFfr8BEtSufO5v6sCcimuu34sVUTvFUKdw0AhI7wO0dAJa
         hY02ltK9bh4mMkuOlNgyFttH6kVrkAgav6FCY5qOH9ZUNO3IYsCvX7DEjuBI6W3z3MWg
         HkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010479; x=1783615279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NxiUl+/bAdRLvWtuMhB2y4s8JQp74XEt9Vmqk681vy8=;
        b=elxwyGmq1WwRRnKafvQ7IIxW0W/2f3MAPLW6+rbWtBxmaane5VNM9+qCRtU2/KYQAe
         Ns8OCRrrSdZX277JlPX7yyz1tQ+kh+uAgPSV9S3urCGWDWkZ1Kco9tmuu/KWSbCawydY
         RmvSswUqeaPcp9nsQMRfU7jdhnhkycdp2Oa6TZkBuaI9xOIpyBDrfRyeaourDXafzoFZ
         5ybp/1LPDNY1yz5HKgvaB24rxZ5hGClyS6sPH6OVl1XiWAQNCBLxqk83BbOvuW+0k1LK
         JCd9evgt3MN9AbIl1ENPMGWNYKih7QRmA/0b5uzqVU9PrOFiMZPuCChC6GtsG+r0LYWo
         ZfCw==
X-Forwarded-Encrypted: i=1; AFNElJ+G2CONfNR8v2mJo8c46gIF5tHK993nTOS0vg8XcCmgJ8ex+ak8xi5FFROYbmg4nC6FmHjZ4tGM9eq97G5L@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZ8dpwIbwtD+jjSlDsAl+CSyrGydBl4v64QwBoftaynfK1vy5
	h5UxCjDoe9t4p9WBuiIRB08h+Qh8WtEs3STTuTZIHrPuRwAJsrmwB4b2
X-Gm-Gg: AfdE7cnEKOJ0plqhEYz/9gjrcsEb/sUVsM39utMN57K66aJLreYTS/UCYWlRz1lZGOO
	UGP2Z80hkJTB6ZEafd8gW953OHUQWZ6NNEZhAhzTzrpHydh7GO0DPnDUIdL9Owj9wSRGOriXKBh
	ZvZWDvdepJ9GI/3MraG3NaVQYM0CHgOGVmex7VbpuxjJ+2AQrNH2br6oLsToFR3OoQHtDBaVLsI
	+aTwFpSIU6rTFZthjpEbXgryIp4vjwmkKQsTYXS9YcRBYm4plvDmaBdwzCCmykRFMbt6GuJrKQo
	1CH8Cc5U5QO/qIpEAaiF3AYQrapwafAHdJD00kBdCiCLSSBH5+ONpbe2eQgxfjn4Q7YhLBXVGsu
	A1n/XIzey1HH1F5wJGiM/MPmO75POa0HF01PGc/HO6Pv1U2bL8gGTEwBMxn2blns3SSoHINKddf
	EexWKOFsNNN6sAWf/8WpNvr3gHmf9UWfylVWJtZ+bA3Qsv78Ixc4KGKrglov/gRg==
X-Received: by 2002:a05:6808:6559:b0:496:1009:ec5a with SMTP id 5614622812f47-4961009eecbmr3729241b6e.1.1783010479414;
        Thu, 02 Jul 2026 09:41:19 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:55 -0600
Subject: [PATCH v5 03/18] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-3-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=1363;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=VSikVomK4BH1ns73BMbLgc83yqlpizqOwQQtNSd/MAc=;
 b=f0lvV79do3jHCXCXSsYbRpRtarC9mgVSKkhulER6lRcGhcvk+QN8AmvDyyE0Yrb439HzJKCM9
 5692WESkvotCUwwymrnmi79GE4b/yzm8Zs7jmAni+A9AaI16Dt2MWCi
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries, and therefore uncontrollable.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports a classmap coding error condition, which should be
   detected in (or before) review.
b- SHOUTING the error makes it more visible, uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 577a07916072..a86e1d5845e6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1170,7 +1170,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.54.0

