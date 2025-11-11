Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32DD369960
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876196; cv=none; b=iVb0S7Hk8uWUbjCDZ6GZ1UULlqQIo/hbDPUfh/3JDuOFihxACkFq6MoQUBo84RYENtwYuPrUzdVHX40kMnyDqCKF6lyWgwLRMwTLNFLLgpKDgwZKoJR0Pun8kpCkzVkDlBbHygKhF0KGpTuborHdNhBcKRC4kIpduythskkWFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876196; c=relaxed/simple;
	bh=qD6zIG+QFIh9H5gMT+JWHMXeNqgfXO8dSPuiOhs9AzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU5eu6Bp9VaeBXuRIiwgBBeo+Khdnn7RAmtVV7UO6r0N+oZ8kKNgrRcSNlXOcHOU7eIOsi4x8PV8b3HfH0eM8nUSyCz9awRNQxbM63Yc5LE2pXlgfQRNiiA9jFcNTWRO85RsN/AMxZo0y3/ksegmLeiELjb9UkJkEo0XiOjWEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N1FeMUeh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N1FeMUeh"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c7869704so3264986f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762876193; x=1763480993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldB0OPyDE9pZ9lZi6t4J5SC+CGo/82OY1zC0z4qhuPw=;
        b=N1FeMUeh9AbsTM9znheALQWUQ0YwCaX4LeGGr8D6SzzXCIUYQDpDAhZNqkuJ8sryUN
         0DFf6jahTH593gBhtp0cr5VKwo7F0deKFMWPn9s4KCzqVUuoiVLzJljuzmWC4KjcpqeT
         eM/OXo/jfbuYwcrpXbQZVwZLa9wrzpWgwRIZ58tThg+gJcUgYx/2E6l2ndiVtOIx4XUx
         hH60Y+byANhUcvaOM1QRL20kL3C5x1jW2yNcsTd1KpQRqcT7spbE82kOWcO8PVP4+rTI
         YYQuh1Sx/HYWU6NgrszHSIq9jy9YLs/V4wxTqkjjnixmTGfTJTAyKZ33c8WY5bIc/GKW
         3oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876193; x=1763480993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldB0OPyDE9pZ9lZi6t4J5SC+CGo/82OY1zC0z4qhuPw=;
        b=f1Os3/URoFxK+fzukhfN6k6nALJd6Grvnw5S/vzu2XwDSNMk1TC64MNd4Au3hkg3Tj
         OJiYlC+c15+PLs7ClLJqMdDcK8qigDY049ZMgb+jotsh4K15yE7xnhZcyU7RUqHxU5Vj
         ubcIeHmHJgSa7HhmSxpHhRQarSBzCmYyhOdaQbbHrcLVjLtTJQ4WFEW3s6oeRYn/Bvt5
         17uuWEN1tEVC/30urDIfiTC3Emo1oCdhGywMDvzA1rDHVcBuEpedGkv+IAZHKOR7xK9w
         l4N7hp8MaXsPnxY7ZBERVudzIFdDVo7ChiPfi2aXg1qydAtA0BcKBmgafnOG9U3jSsQF
         xXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnHnz18wgPHAKun2JESZTbrtIBA1fjZOl58Eg+jS59MJXMw+JHAetm6D6dUWx/1vwy5SRRXsoYgowcPAVW@vger.kernel.org
X-Gm-Message-State: AOJu0YwxoAFfMvXP0bA1LCkwgFRZaz36h/50s8HI2tGhA0gnbTatXeSh
	gK7CvziHpgdVMBCmWPomOvnjXHp9di3PoQgwdGpGQc5WGEvtSwEGshgafdZlWSHTGmE=
X-Gm-Gg: ASbGncvUSvR92l5bwTjnKYwJnphbGGSHWOac8oIVzNA3p7rJMjdJGaiIFZ8WrBYZ71W
	E+z4LEyKETUdodo3wmb4rTMzMpYs2lHv5wsmUmqM/CMAwssIyZAbb4dJR+HdjdHZTF11+76KaGq
	grKKbOXB7m8oc0Btq+vrfdd4H3Xqg3xmVPlfuxN69Pq0PKDSFiVBWNvkHMSe3y/sb/En7kUgioN
	o0P3zTG+JD8RgsHIADnPIRLElhpoTLo7eZhbf770P2A/R9kcBFr2AxZHs+ku7RSCoHvhguQHn0p
	ZU+SqnGr8PSpKd/odBytfUMabjbuwY9IQbvgqwyBBNd8Gneti3+r14IrCpYFjmrW1Uh9nHr+guY
	wONvyLbeetPyZ0hFipyM5txhqjrt224V3w0iAYcD4Bg34V1DRXk9KwaY9SPH8XSlg3TRPbP+MgW
	u8BAjbI3fs5KOvUIncHw==
X-Google-Smtp-Source: AGHT+IEOSm7C5wtpa4ZrHjhS6rbYwvS1yk5B9tIcVm28eW4cAMJObZ0VcTOXc0R/m5W6dUpuHdMeIQ==
X-Received: by 2002:a5d:5f42:0:b0:429:bca4:6b44 with SMTP id ffacd0b85a97d-42b2dc1f4e9mr11678592f8f.13.1762876193119;
        Tue, 11 Nov 2025 07:49:53 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm28269916f8f.10.2025.11.11.07.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:49:52 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: keyrings@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] module: Remove SHA-1 support for module signing
Date: Tue, 11 Nov 2025 16:48:31 +0100
Message-ID: <20251111154923.978181-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111154923.978181-1-petr.pavlu@suse.com>
References: <20251111154923.978181-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SHA-1 is considered deprecated and insecure due to vulnerabilities that can
lead to hash collisions. Most distributions have already been using SHA-2
for module signing because of this. The default was also changed last year
from SHA-1 to SHA-512 in commit f3b93547b91a ("module: sign with sha512
instead of sha1 by default"). This was not reported to cause any issues.
Therefore, it now seems to be a good time to remove SHA-1 support for
module signing.

Commit 16ab7cb5825f ("crypto: pkcs7 - remove sha1 support") previously
removed support for reading PKCS#7/CMS signed with SHA-1, along with the
ability to use SHA-1 for module signing. This change broke iwd and was
subsequently completely reverted in commit 203a6763ab69 ("Revert "crypto:
pkcs7 - remove sha1 support""). However, dropping only the support for
using SHA-1 for module signing is unrelated and can still be done
separately.

Note that this change only removes support for new modules to be SHA-1
signed, but already signed modules can still be loaded.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 2a1beebf1d37..be74917802ad 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -299,10 +299,6 @@ choice
 	  possible to load a signed module containing the algorithm to check
 	  the signature on that module.
 
-config MODULE_SIG_SHA1
-	bool "SHA-1"
-	select CRYPTO_SHA1
-
 config MODULE_SIG_SHA256
 	bool "SHA-256"
 	select CRYPTO_SHA256
@@ -332,7 +328,6 @@ endchoice
 config MODULE_SIG_HASH
 	string
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
-	default "sha1" if MODULE_SIG_SHA1
 	default "sha256" if MODULE_SIG_SHA256
 	default "sha384" if MODULE_SIG_SHA384
 	default "sha512" if MODULE_SIG_SHA512
-- 
2.51.1

