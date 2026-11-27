Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795737637;
	b=EpjLFyl8oIbzrsraINVm1DVaK4IWvBooAD5+kKdGt16f5+e5CeV5sX25Oi/Y83Kd1IHr
	 x+OvI5OYZhZpXjb6yPOkKa8YRyRqCSe/jUzIu1c+444fmPtoGTzWhxY/zfA+MJpMLD2VI
	 ItpoRmGgH//KnGF2L1tNtJLijexVZe2Nyu0wxqFqLrb0XiRn2q3QMP8XZBud4Sn5PuMUr
	 l3FJt6ykBS4nMJfShuU92KppGFyVSHNe99Qr/2daOQH/k8QDsta4sAVKsgKjqiDaVBIvY
	 8QFcU4uQp5/mTZ7TC6llx941egbUdojxblnFzQincqJo3SWhtycKnypitlyS+iGUePQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795737637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=bI5wgKSxHmXVhcmMGt1XWUXhGqSxXd41m+lLl/fjbr4=;
	b=iL6rbuqOUY20klNXRTNKbGno0FkYD02LMdzBGMwEETQSsyDjq2JV6ksHiuYq/QuhF264
	 +EmmeD4bRwtQJZRzkLYRBQoiE92uX3LUKDSn8mY4sH9a5rpER0BSqR6JhpUAhR5dGG7to
	 zxPpESTFO9GAGLj0siuLhDdLI5xf9ywRxP3inmhYe6twhMDuZ6SBoNVawbhqdmhD9RRrI
	 XD9H4IpeH6T5uyVVlBAeaYA3n2z5RUJxqe1M9IJPnGbP5B6a3ihtY47d6X7Jb1TL0pyJc
	 qclJyxiscQahmxJroqvLXYX8MhSA+lysKOqyCCz3qtKzUbHZ6GKmuI+aqUucXx20eLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QHUw1TNk;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1F606A339
	for <linux-modules@vger.kernel.org>; Fri, 27 Nov 2026 00:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBF1F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QHUw1TNk
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so6807191f8f.0
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 16:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795737635; x=1796342435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bI5wgKSxHmXVhcmMGt1XWUXhGqSxXd41m+lLl/fjbr4=;
        b=QHUw1TNkXmTEOzQX8Nylpr11eeDYM5iLjNsukKHMgqk9V42oWhGyTLN+7wxZwRyM/w
         3csjlbjRDgpgcdzNVGtjc6xfg7iGxplIXyqnVoDNO9456MxYBoXS+Ek22/v6q7/8VJHA
         GzFR9sPBhg5pU+0egnAVpxipNLbXkj26Ol0V2GILslRJB+Gt3vIW4ckBRQW47yHxb1Bx
         39SWXFGql0DWFd+CppzSC7mg92CTrdd6fyQeBO8+a4A5A8pyokNg4D6Ng+JdFVzRiRbG
         BOOQl6M9H2JKfoQdZwiFMygnid5IGGZtPxuVlaeXlU5lm91lKTF88Ox3ZGXvxg1KAaLg
         Qocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795737635; x=1796342435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bI5wgKSxHmXVhcmMGt1XWUXhGqSxXd41m+lLl/fjbr4=;
        b=Fv7CP+Lj0ZDh4FV6Flj79N9mss3pMp9ACuTujExDyjxIvpikZL04Ff9wRQIpCjZ9/M
         7FKaZnmF+peLtLVrNOCkuqBIHX/SsUYCfAyivXZPNCsSCdOo9gPBcd6gJYncJrkd6bPt
         W4Bp2qIAvXUNOsI+7Qrnllq4WSVNzwSrfvqHiFRSzWDHDQUGMeG1Kjtwe5A9+KFTYopP
         7PIkiCJvsLeTObkTCX1jco020kl/YxqyyUhr65eAHqIayDu8pa8loynz1+AcH2gEuAPA
         CBSBLNKuelvSeJzYx9dtfD5MtU9Yx+cncLEB0B8+lX/Mkr2VF6KhSLhvyiF3cecUgRty
         Pysg==
X-Forwarded-Encrypted: i=1; AL+hErHfXCJEJizK6GhrXLqkDi8xb91+lk09tfxvbykBbNCkuObe0NsI84iZtV8EQWIKQXGf3pR8aGELPWU38A08@vger.kernel.org
X-Gm-Message-State: APuU4Z8fMa1GX1D1aLU0wyAdRw5ON01fTqZDHsfiKxThSy+e+TSA9KT+
	dsXh9xW+ZNG8QocMZjU6olcGqEeKgmE4Mtd0QW7PewYDUXaXhwe/wxofHn78UCtEpog=
X-Gm-Gg: AZFdTZdOP4szPUAQkDQkvdaNhhf8+IZeDpuJeAwrg0NLr/qMOkKdBjz2PnW4PcKppOW
	hUbiFYBKw8coyEWj6vBlInJ8YiI69IHI1wn6ARoqEiZIgMMsEVyOM2KBIe1IBPXtZCGoaJxytyx
	v4Y/7Zw+BeD9xpNzLsjibkFFftLbshbzMIXRx+bD2d7IWNObvz2FZen2fhDIVhnel8dQ76aWlf0
	1/lvryfp2cqs4LUgoPdQJUmMksJvO18BwcmhFyx99zsqOr8vY7HtkvK5VU8HmTkO3M6ODHCmQfF
	ywt9JKygi0olmdJHg5aLKtV4UqE9a/6fsZp2rExoPEJ4OFYSF0/uF4Q98r0oVZZ6Nrg+QhU7Q7H
	5ElEsYosgCK5f23ogoJdt6dc4ljxcn+HHHiyfRGnhjSdBAcL1uWOkb2MzHBKQKUael3cyXL0DDJ
	BdFrQ+lNNzf/FWu4SQKWhIguPhceg9sC24xdfVp00RW7bMuOJUe4aIrbVqdpTQ764yp2bazVaX+
	8qsKtSKjaJvjmG5ZKZ7GUwMLMxtVTv14D+d1dgGLyCInQwUdZqbSbqXJICFEmr3i9SlNVGdtufj
	8cRno3JRZSR8ce7w6hpSk52Dx1fBBYGyxQN3Xe3bOBA1H0fjhw7cWCVgENdKJ0vFqB32vrTlZLh
	ujatShZWManzEm7G3kw==
X-Received: by 2002:a05:6000:4b15:b0:48d:df08:307c with SMTP id ffacd0b85a97d-4abb8ac0d92mr39000455f8f.44.1795737635110;
        Thu, 26 Nov 2026 16:00:35 -0800 (PST)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm45536616f8f.29.2026.11.26.16.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:00:34 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: nathan@kernel.org,
	nsc@kernel.org
Cc: samitolvanen@google.com,
	torvalds@linux-foundation.org,
	ljs@kernel.org,
	david.laight.linux@gmail.com,
	sashal@kernel.org,
	lzsx618@gmail.com,
	zuoan.penguin@gmail.com,
	petr.pavlu@suse.com,
	jani.nikula@intel.com,
	xur@google.com,
	sidnayyar@google.com,
	robertusdchris@gmail.com,
	acourbot@nvidia.com,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH 5/5] kconfig: replace XOR with addition for expr_lookup() key generation
Date: Fri, 27 Nov 2026 00:00:15 +0000
Message-ID: <20261127000015.3662267-6-julianbraha@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127000015.3662267-1-julianbraha@gmail.com>
References: <20261127000015.3662267-1-julianbraha@gmail.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Linus noted when reporting the 'make oldconfig' performance issue [1],
XOR of the hash_ptr() values will clear the shared bits, increasing hash
table collisions when l == r. In Kconfig, this happens when two sides of
an expression are equal, for example 'range 1 1' in fs/erofs/Kconfig.

Let's replace the XOR usage with addition, as Linus suggested.

Link: https://lore.kernel.org/all/CAHk-=wi_GuySe0L-uCAM2+nScCLYGBp5BLi6UUPR1gALmNM_3w@mail.gmail.com/ [1]
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 scripts/kconfig/expr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index 8dc73acb08ad..e30554807d12 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -35,7 +35,7 @@ static struct expr *expr_lookup(enum expr_type type, void *l, void *r)
 	struct expr *e;
 	int hash;
 
-	hash = hash_32((unsigned int)type ^ hash_ptr(l, 32) ^ hash_ptr(r, 32), 32);
+	hash = hash_32((unsigned int)type + hash_ptr(l, 32) + hash_ptr(r, 32), 32);
 
 	hash_for_each_possible(expr_hashtable, e, node, hash) {
 		if (e->type == type && e->left._initdata == l &&
-- 
2.56.0

