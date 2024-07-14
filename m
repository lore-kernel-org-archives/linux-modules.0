Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50569F4FB;
	Sun, 14 Jul 2024 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720955877; cv=none; b=lMV8BwWQsxg6MuKScaoAlePUddfLq/MdOstoLOGd6g1LRNFeAFfFNmuDp92H1QHrOV6IKBN1j2rTV5vChMw+Bqp7aovpT7cbJwaPHbaoevTU5i3QA+tsu0vVjTiuRYxz2xEfrzUKn5IDnCS83QWgmai+mUivew3oYLMUL9rp7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720955877; c=relaxed/simple;
	bh=lB+D30ieUHrYR/nzmhn2wp3IdbzaoZbtAxkshjUDHbE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Wsknt1Y9RYv/gaTxMQZ+wNOp6diIkDaxJfxjqbgA0kztWCXtrUj+8Kb/K2o2Av6qz/jrAo07CPRh1HMB0ix6sAj01d1KtPmmJocqkspeSwvL81Ng8XSuWbYESY9lpm25kLJw8Blk3T+xqMIGuOJPycN4rcizYmWwMtx8VX+gHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OnIy8aqG; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OnIy8aqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720955863; x=1721560663; i=markus.elfring@web.de;
	bh=aZKbjgcdoWWnRDIxEAnvTwtYcMVZe5Hxddsqm8NEs2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OnIy8aqGsVlZPcrpdq5QicQaW5/jdFYM3/4j6Oh7NrjqUubk8ax21mb10lP2599A
	 +KH1q8z9jMOSRF4wIDwlhKNmvq5gD1QW+9GzzOZbIjTwIIImlaGSY9dgl57da2f4Q
	 cT5+pndb+/vqxfwJpCnAn+q74Z/TZeL0Ol5EBvyav9T3J9a6GdLUCZ1vjD3TSC/WJ
	 UymVEnu6plSRaRCkKiEhDGTiT9XjKD0AhbHvLLWAuiZ9kaOyIIIziDQbdybPfGFgw
	 1UAnPVpixoj6fOpQa2jniDGpcVj7JwYpfXynHAJ7TyZD+PNVxn2ToeAC3ChB3y11Y
	 /xQ59o7PCMmXLCtQrg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMY1D-1sktiy1gAx-00ILU4; Sun, 14
 Jul 2024 13:17:43 +0200
Message-ID: <0750654d-a21f-44b5-bf90-1474ec5f88e1@web.de>
Date: Sun, 14 Jul 2024 13:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-modules@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] module: Use seq_putc() in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t/vPEWGt5TRaJj5GcdxVo7fWeXJXU/h6bhk4OELyZvpUPPKdPJM
 KDZCNlz+hFd6NHeVHTBiV+Uj98ApFqs5IZagQqKfCM7COs5aZlAoTFmwvOL6zkdPhX8abuc
 dIerOUXLjXzoX/vmIyN4/FQ2a96mbUoq4brzQo4lyGx/dFhYecSgtrxV1m5UjKI8r/q5DNw
 8n6MFGJreQzczKVZ/NTuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bn71XKnmFb4=;4wR7eKLxkpW2dboBU2J/aw8a7Nq
 wxIITTusNiyX+bpfu08AoRpETV18s6RgFYMnu+dSSlteaq6KKTpLj8LR57eNkVVaq1zAoiJ20
 D6M9rbKRQ9MwgrieelSotBa56p271QdHMlvjCg3pCGJZ5WLn711sLfraK0ixsQoyS/gx86uoX
 J0Ktb6FDVvQDqLkwb+qajccjmh816L/1QH+cWGvFvwJKzzLsgDuZ0/Sq2yFijEh1mBYIG5a28
 eZ596990rp056W+CKyCWso2d7BGOuQIr1GEsH1fOLf3W9K6ECM4EyAcx07B8ADQOzyMJSzd9H
 LPlb+78OdhHkeek3G8FBtl+dUfNhVPKha8S1u5lHsN6CLslmPM+h5zDl1lU25xpZylQZTccKP
 yt7cIHoam+UNW1gJ0YBp4mR9lbFul4gHyZRfzRg01TzSuUueYFkPS0x1p2AhL/7D0XPXIZOpp
 geMiv0JkGdtE767cSoyr9Ef98tSZ4A8s2IJfLT0nQ2Msent+Ma/j+vzgQY1NktqNnrCtLHUus
 VxNf6Ij9r5jkIp9eCnTByZtYcvhY7rkztBdE5YpLDk2MMWO1VRT0wKm7r/kKpUnpWPsgxoBaJ
 0yWvrv83d+Bn4F8K9P6JRmR3oh+ESMfVEjQAHEcyJwkDW+V7nnR/aONsNYufRVksdnK0eIvC5
 9QXkLpyf/zOfZgnoew2zCebfaT6lK99asvWIO1PYwbSPvY6E5mwbdo6OoVNbk5n4JTO+2H+FL
 +wPBp/eqIHm8G9lvzreu5rbJ+hx3ce+pPtM3WN5wRYdOrun1iWm1JXi5tyhWtyt0GDtBlpqwx
 aE/n9plHNs/rKsqxyvlZW9lw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 13:13:15 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/module/procfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 0a4841e88adb..dc91d3dba8f3 100644
=2D-- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -35,7 +35,7 @@ static inline void print_unload_info(struct seq_file *m,=
 struct module *mod)
 	}

 	if (!printed_something)
-		seq_puts(m, "-");
+		seq_putc(m, '-');
 }
 #else /* !CONFIG_MODULE_UNLOAD */
 static inline void print_unload_info(struct seq_file *m, struct module *m=
od)
@@ -99,7 +99,7 @@ static int m_show(struct seq_file *m, void *p)
 	if (mod->taints)
 		seq_printf(m, " %s", module_flags(mod, buf, true));

-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }

=2D-
2.45.2

