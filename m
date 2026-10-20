Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505246;
	b=yA+Alw95hbDpfemc62lWW6rza5XWfwcRsMuopEq1v9MZiK41orQd9/SPkEuTbX1fUEak
	 e45d8mcR5bqvCvo5sdUnZJeaTv6KPbAN4DXrSxAoKNH6A9J4SkN39rUzINbIX7b+shATR
	 ZSaBewZrrXqa7aUgulN1KosDY2LFsCPlzLs7IK/rN/acRke9qk8VOl0hrQ/xCxMOt5T5n
	 z4FoeN4Pxsi6LVMKHj+aSFQHue4BcEZWa4+exbzSqc4hG/RuljmCKmLPEd1vaXR4BKEsd
	 EJnZOhz0Lh4ljaYTIHH60ZEmjJfDR+haOcmOjYfZCJzX6znDuoBOM0VkX+DG76mamvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hUv7uf8ufBNBf/i6W9qgwPGx5KWz5jW4iKKV5HAxgy0=;
	b=j2Y91EjYNlsNagl6Ps8k6r3Gp4XO8cSekM6tHiQpA+VwD0qnXJyS0EsQeP1CfAicjtZR
	 rYiwsLoT4gxFI8GDRSfn0xs0owf2pz9k9wxKB9MHLjLMhXkN7T3BZu0tzGHYh8lQMxx7u
	 ys5w14dz2mmNF/jaCCct7eJlerzZYgi0CNPHvwh+9PQo37nsyB+MbvRrg8bc6dbC8z7f4
	 FsSWP12cyVs3BrpegjKAVHOqmFPDCLOqSvjYtR4OvQnP2qyCXZZFbfA+m6BC2N0weTKEW
	 PumAeFQf9zk+tkWIAPAu5qLrWYJL06m002ZDioszSbHbP5Jykd0mAE3hf2xOyv6ZcGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RKgmoIyf;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089E60A2620
	for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 14:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A089E60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RKgmoIyf
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so5118805e9.1
        for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792505244; x=1793110044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hUv7uf8ufBNBf/i6W9qgwPGx5KWz5jW4iKKV5HAxgy0=;
        b=RKgmoIyfmeN+1A/ODaqCWjVB7LBKWoUaJ3vU6tbeGRWCdveT9YGfE/A7Ax/gYE196J
         TqjLniQbMy/lWZfRjzdG2a0xn9D1YURb2EIhEbiAhBd+A+l7TUziWm+x7Alixsygt2yM
         CEeHFYI3rflQ9zY90CkeA28esvIjhjHwJpX9040H43k3iXcKizmQ5M+Rp11Og+jKQ9F2
         lFK0AgQ6lQStulC0Uq7TEzak73HxGAkJBw7b1mKZ/LFKiBHUaQsXy/UwUsWn6wyinQ53
         Df+z26BEgxLc8bPXztW93id/wVzZT6RbptXmxsnr/1p0rLjXnVYiKcS9R4jJV2JNfIqy
         n77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505244; x=1793110044;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hUv7uf8ufBNBf/i6W9qgwPGx5KWz5jW4iKKV5HAxgy0=;
        b=gHg0DXk1liHSsbkSjEvEMHh24NeBfVNlVqEuFratdriZeM3+ttBhi46Uxc04BOPwD6
         L5+Gvcrr/jpZ7rUMfxEzL3nH19zJffepuR+KUCEqlBIfys88bQuzhLxGhsAfvVb8PeH4
         3eLKfk7tsm3FGNTyu78+53PIUTvggA6Gm6NE8xzFZlxFYsO0VniUTqKIQTY96VbbGZD1
         Y09Q/tmYf/VMbaPdpONxZWzfzSEf9+1bBwQAf0+9CW0S2Nwdxr88tF7R/x+opHnjYXJw
         N6EWamek9D5Lsmp4U2qFmYcNdpTBp+rFxODEqTxr/nx0+psVmN/qgWA4VffVJ/P+U3Bj
         EMKw==
X-Forwarded-Encrypted: i=1; AKwUvBzFZCLtPjZTZBRwUJGBq4yp75yM8JHD5ZqHKiy1c1V5lmIytTEI6oFiWnZMlsHRgekAUKdPXSJq/c/7NW1L@vger.kernel.org
X-Gm-Message-State: AFq9FYJSoulImgccsIEvVOmto/xXVSt3x46KBlGiwJp2qyedjFQ9FcE5
	mqLfjGjqTbTzz06F+D893pPVngftkqs390dw129tXLQOwl4oAxgdasmnPk3ueHzvONg=
X-Gm-Gg: AYBFou2qAo6aEw8WcXSGQNbjmL4+8j+qwIIN7qexIuLnwXqmtY2G0uoBnGr26K3Q24Z
	evfNaZaNxUI+F6Mi52AkF56v34rrtohkr1c4DE/3Fjie2DVNTjCgJPY/sjpOzP2sp1FWgDPYWzg
	JUWp9UQWXCrOVlR4QVyb9XlZY5ZCksIQ3obYvEHW2/WGFr0WiJPryK3iWSj+9YTxlSEz2pfcUVk
	v6WJdQ8/H7QyyfzaA4UCIh+2FalBjbHsEnzpNxIGd1VFlc9HDMvToax05pmcNsNrxQo8idNkU5E
	j7s9BiCiFlCweeCwkYekONo2Nks1D83KqsNKhyYoZHGg/C3Tg2+GHDsCPOVbp3KKnlLG7k6gGJT
	661fweFVpittK/obAEdKvZlg04TyLXv96aW0xR3QeUtLQ+vbUtARODUDMyDxlMvjrh6EMswRRgP
	OJ5cwDivQdHBUJNt/CGCzyjsc6LHiodgZLHQQQnm1nnGKVly1D8knV8SSjIn3vdAPA4a+Noxfzf
	nks6+evWxuGOlo1
X-Received: by 2002:a05:600c:1c19:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a1f4d81b75mr58480915e9.8.1792505244014;
        Tue, 20 Oct 2026 07:07:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce1479sm75602805e9.14.2026.10.20.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:07:23 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] module: Fix data race on mod_unload_taint::count
Date: Tue, 20 Oct 2026 16:05:20 +0200
Message-ID: <20261020-taint-unload-v1-2-d1c764889afc@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
References: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Updates to mod_unload_taint::count are serialized by module_mutex. However,
readers may access this value concurrently with these updates. Since the
counter is a u64, this can result in torn reads on 32-bit architectures.

Fix the issue by changing mod_unload_taint::count to 'unsigned int' and
using WRITE_ONCE()/READ_ONCE() to access it.

Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/internal.h |  8 +++++++-
 kernel/module/tracking.c | 12 ++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 061161cc79d9..70ef20b97c84 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -257,7 +257,13 @@ struct mod_unload_taint {
 	struct list_head list;
 	char name[MODULE_NAME_LEN];
 	unsigned long taints;
-	u64 count;
+
+	/*
+	 * Number of times a module with this name and taint combination has
+	 * been unloaded. Updates are serialized by module_mutex and use
+	 * WRITE_ONCE(). Readers that may run concurrently use READ_ONCE().
+	 */
+	unsigned int count;
 };
 
 int try_add_tainted_module(struct module *mod);
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 5bcd1c2701f0..873fceb30526 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -28,7 +28,10 @@ int try_add_tainted_module(struct module *mod)
 				lockdep_is_held(&module_mutex)) {
 		if (!strcmp(mod_taint->name, mod->name) &&
 		    mod_taint->taints == mod->taints) {
-			mod_taint->count++;
+			unsigned int count = mod_taint->count;
+
+			if (count != UINT_MAX)
+				WRITE_ONCE(mod_taint->count, count + 1);
 			goto out;
 		}
 	}
@@ -57,8 +60,8 @@ void print_unloaded_tainted_modules(void)
 
 			l = module_flags_taint(mod_taint->taints, buf);
 			buf[l++] = '\0';
-			pr_cont(" %s(%s):%llu", mod_taint->name, buf,
-				mod_taint->count);
+			pr_cont(" %s(%s):%u", mod_taint->name, buf,
+				READ_ONCE(mod_taint->count));
 		}
 	}
 }
@@ -92,7 +95,8 @@ static int unloaded_tainted_modules_seq_show(struct seq_file *m, void *p)
 	l = module_flags_taint(mod_taint->taints, buf);
 	buf[l++] = '\0';
 
-	seq_printf(m, "%s (%s) %llu", mod_taint->name, buf, mod_taint->count);
+	seq_printf(m, "%s (%s) %u", mod_taint->name, buf,
+		   READ_ONCE(mod_taint->count));
 	seq_puts(m, "\n");
 
 	return 0;

-- 
2.55.0
