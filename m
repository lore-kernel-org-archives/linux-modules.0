Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA24145FE0
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520514; cv=none; b=jRFm3ZGPyTloxq1mk32TmUwWZ5gJK412rSkbRCUUPYdwmFHlUTqlGO1VejVY9/RRLg4+Nq61NOo9HY5/IzVfOxvJ4rpZN1UH/rutC/XlmobK0MhNpISYyxaiik4BcGqKyQcDhpeoc7xCDp2wXRGc+Y51XQinvfZDPLjtF+Fjpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520514; c=relaxed/simple;
	bh=Ah9OubhC/0J+O5fnf6mytQN8u50S2Bl4xoeKfk7IEd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAJ0BK34UgnOKPF3Xcx96TQ2CMUsl5oNz18KNbX9krBsQp71z+5dBo66ELa5dB5nRc+anoZDEVekpCBR8lObd+Bggt/qJ4I6WyncWvmqzn0UrIQ2+DuDqqV1QoTtdD+/7VUBi9cym4uKtV+DGl1gsB/4Jof0U+RlY6VTYNy397c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnYOsHTS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnYOsHTS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d77f6092eso4707594f8f.2
        for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520509; x=1780125309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
        b=mnYOsHTS6C1ZmiYricCFU1qon5J5Bj8Xdremgr8bCNl4r64JKw21B9n4+GI+9UMVUE
         rxqxT/Y8MlMmd3wIz8fBkglKB7s36J7uLl5Tn07TQ6gXCXd8HvBAT3FM6GBiLUkgF4dj
         PP0peeYIse3Lm0luFtDc59NmwrrcUxipa0AZ+cT8NoJPImBmNuzpLKJ8WmkVlzb0Lzxq
         VwPjDo+mFRQBXnry84pL6Ejy/r4/xC8qD9u5VcRlWM+IGwBn6WRq2AZjXD3rmWedp7xW
         HqPqDYXhATvvlD5z1I3ByHiZf03FLEuMy4UJraccOONYwW090dYE4mQu65iwT7yUIx4Y
         3ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520509; x=1780125309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
        b=ZROrAR/LdjG/Ldyq+0LqIRy4de2yTzUBYw2woR4IBuBf2eehOHJPqwAxtf7jXvvPbh
         lvYVNitzsSMC8NuIWRBVC5XvvgAeSyL9lFlYtpnIMkXUsGqHFTC6h74Rntttp7OXvBAG
         9D/krmprkTMQQVu/RlXPjnnftBUEn+Po/WVpuZgtDsOZra2v6wt2VcIHl8wp2qWs6uSl
         euDTuckb/IkC946jxVl6aWiREGuttoU5Fjy9zc6v5DAEXovwTNXsdxkY4ITg4UTpWcO7
         JEXIwBy1ulhsbkAxsYI12nszGekM6+2uv/rzrHI79CHd5JzbzvFPgRljU/TPc3yGz6dH
         mAEA==
X-Forwarded-Encrypted: i=1; AFNElJ9+ZtlUpxG7qBJvMMbVHMmtOefh40iB05JO/TJeYh7/TKvrhALwgz03LZCJoxirP6G3ozuZtFX96eHDbrW3@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXZzQkUBPvgK2MZOpx9BYlZLScixt6t8PPXRSuOTLYzHitplc
	lgsRVUF/zMJyXwaWBRuV5vfJDVlEBKBGlqQKYzxU6jkG+uea0D1pEU73sj4mUmf41pQ=
X-Gm-Gg: Acq92OH6t+nyxpMDucoY7uv1cZuqTtvlLO4BI1ml+B1LiPJIHzM8/IylToLReyH9Xv2
	p9KTmY6RwwsfdxKiarN0lGU1v9JlLTyNl1HZIj8JrjTZYpM75t7C0Kro8JKhkWYZTie6MFAQByN
	FdkGNhhaM6X6BCdVhyB76DiPA4KaRJ91NeQmBZj+8o5P7hXSm8br8iSs3n/kFbzLwatt69x4OfU
	kXWXl4SLg8UPr35bM2m8ivk91WlmsONlI5dr/n+yT4MRYYbC03FkmknvRMmBlF/Ezt5itb0gDOY
	FCkyEqkLYuOaPIHa8Td4GauEee88XEAoto7ThS4aKJInzMjglmnvQDdZ1wO/acnQWB0OMWaa3Hk
	KrQsgmABUVuAivZH83EiI1Mf+QFvrOrjUl6G7VQvxCiCA1g+IiZKe1OBLaeFQRKu6AiUE5Sl21d
	HMJlte1pGnhrwYbL4+tvj69vLXwZs71LdrB57dEfI=
X-Received: by 2002:a05:6000:41c7:b0:451:66e6:501b with SMTP id ffacd0b85a97d-45eb3324e34mr9651283f8f.0.1779520508486;
        Sat, 23 May 2026 00:15:08 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:07 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:43 -0600
Subject: [PATCH v2 10/24] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-10-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=1309;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ah9OubhC/0J+O5fnf6mytQN8u50S2Bl4xoeKfk7IEd0=;
 b=pwcA+Pegzk3CXbQXnl4Bmr24EnZTQsoVG0QcFjlTa+oIhKNkKDOhgNtlhtZ0DeoUT+EatexUY
 g3lqjPBN5QDCaSTmisG4ORkEm7FKIG+zXYtZSOwHcVuXgKVw0paJe2V
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports classmap coding error condition, which should be
   detected before review.
b- SHOUTING the error makes it uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6b1e983cfedc..a9caf84ddb22 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1166,7 +1166,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.54.0

