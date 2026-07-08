Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FE3B71B9
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477124; cv=none; b=DC6mKKc+KCEArARl/bY7ZhE/edN6Qsm/qf5Fv/uCt6YbSDeqUfzP+ijZqp6MyrVQoPt/e8d+kmyZeAfZAaF3piA4fDQNytDmCyGqYGUlkYAI3GPjN2x1IfTPi9QxpI/GEdDstdSjFXEAg4cOHoshW1ohQGX0iGfslUl/c1xBiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477124; c=relaxed/simple;
	bh=yfxjNCD2FfV6WQ7UCS9hJEIU3/cj9TtYhccgD7F2GOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cm19v8Aa3opxI+pzCnW05ytW7lYnYgFX0SH2DhTSXay73uxOtoM7EV6pdArB5KpBKJbcdxWOnpzASxm72UZ6n0vPTkBhj37bvyCoHx19YtevTEA9B9bPpGFwJfZCu0XOq/42CvMsqkAnnK+Oqdcckie7BFZQT+vF5hqCIhRKD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVmUZcQL; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVmUZcQL"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-495c63c41ceso111761b6e.2
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 19:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477119; x=1784081919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
        b=rVmUZcQLaFw0aNmApg6noNV43uIbiXNhcrYwmKT2v5ATs44QHqEXN2gl9qBnhTIoKM
         y11v8/9pWYpjo697LEUyIKhWdQ8CC5KWEpLBJaobQ4xIoUKsk1u9fKCdHgyMzTqhUVGE
         KCS5iPtB99xFqDak++QSBP8Y82qWcXOYRW+sMWHQj7H59jiMrnnBeRCYdAkQ2mAej+8G
         k5+rdPsptizeYQZAtHA7PTIQfZqJlf9v4grm+IaUFGHO7ifm0ggyccetlw/oWW5x3S/F
         xRYCwmJvl5HWyJlcW+y3pxDyM8IZYzTUnUOlbzcF2ADBEuxcyoVlvkEv0ZROmqcOkFAO
         NJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477119; x=1784081919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
        b=FUcNaq9VGESHQqSCAjmNtxwmAKIHFmj27Zl0cdnWeaWOXtNM/TeqTGnPdqBN+xYF+N
         t1Apg1H5XpteUKZIl4XrrbvH7A44vwA5Ts1IFJ2HgeYN1M3MExTA9uxQx7KEG3IpPw42
         s2mYHLQcPVZrc2//wtx3y59An6nngK1klqbs99BB83IUbieB7bY7e/WwfkbVxhGxSTuJ
         WIUUv8gLgy0+9TobiUw6SFIFmJnNW2guu0qXvSuOm/XAZhQsKXGx4yJtD5E+CvJiRDE6
         ZUAm5InYttK/jciduR/o9jn0NHlu044eWYddh9Z1s6dUaX59sWEdpL5wTiYxMZBosmo0
         nYaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5meUJ5A6iDXacOqM7a4CFfbwkf87EccTIR2InEYTL36jjMcCmyytzip04asQTdrU/d/oT19s/LMwJpD36@vger.kernel.org
X-Gm-Message-State: AOJu0YyPd83tjXb41U6jM+8Qwb84c3Sewnt8jrzBaCAt1R5itfHdpqC8
	y4sYHSQ0nMvmq0xqPxGYAsUaeumJ8uJ6+X+NZHVfn1usfBurLpq4I96a
X-Gm-Gg: AfdE7clHgEjmX5pvnB3QMSgEMB38aQ68IBtlhmkjle72NxEqIPoRwg5afTrEflc2mbI
	aykry5b9+pNDaXjP0CGhL0g4KrHBUqYvz8iPqqAJNtZ2I8kF2oMkEPHUbWz2S4LjU704VtZDq8k
	IO3dQDW1QzNKmu/As6S5iXIjMbLv0BXmswmXRz9qKqQgce7tX51U/TxncbdaCHf93L4LJ6WZeSf
	jk/xxSWUTReOzB9iRtQj7oBzqFiAcHmK5AcIIu4pYi++/td1XCA0N6XQmMk6CzPxltcE+uovBkh
	Jfg9PdVEPloQ+Oq6NQa2vU5qDpkD1yijra3egtbX7be5ZDE/2igKAX85ZYTkdSFAol77NZ4T8BV
	tO522RhFi/jxqCF8b9/Ri6ioIeWtw0AVgfZMLigX525otRG/EnN284BsChdWxsoM2ZVXIoSwcoi
	uzFRekM0oIciTmnHvy5DXQiQ/kQGn0MUPewuo8ed0ZUFRw08MY41s=
X-Received: by 2002:a05:6808:1385:b0:496:301:36b9 with SMTP id 5614622812f47-4a1fea2d9fdmr467296b6e.0.1783477119240;
        Tue, 07 Jul 2026 19:18:39 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:08 -0600
Subject: [PATCH v6 08/24] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-8-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=1375;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yfxjNCD2FfV6WQ7UCS9hJEIU3/cj9TtYhccgD7F2GOk=;
 b=BqO4fRVBObl9QNOP0WewNHKxLyFZjbRWwWNClrxuHOAw7XsQmdRiZGqV/r7Wn3OiYiYYQsKGT
 PfAkGsNm/bUARzjCeCDIMDx56NqFAFY351zybs4JuMgykY0D7McoJD5
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries, and therefore uncontrollable.

The control-file displays this condition as "class unknown, _id:N"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_ _id:N" to loudly announce the erroneous situation,
and to make it uniquely greppable.

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
2.55.0

