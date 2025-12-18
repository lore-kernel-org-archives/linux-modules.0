Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1771337BA1;
	Thu, 18 Dec 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091613; cv=none; b=GgKcbBVUVfIJvetaujyTs1NhYXuxFNDMnNOjd+c+U5kk/619qxjKV+jGvbRicQOBE+UJa+xpwPczojE/G75vegpIxOpEmcIjZfU006Tr96cRtRXbiNk/59zRbI8jdzyqCbhAMW52zKZBzjbGkg1TIlaTrtr17R3lzsSGAFS92xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091613; c=relaxed/simple;
	bh=T0HudyPQiXlEcaSonXnq9yf2eOFygMh6mpUvZEIaQq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkUv6aLSS2AaBSzcph+kHOBNcdL1w24lxfnMDEYyI3IOYAnJaBccMFIKOpuML3FV0SVy9Jp+7cfMulMFZ2pc9nU33Cv4Wknuln273nfazztqcneYms53YjHN722hfKg7ydpEZ71r4qRs29FuGwyLYv41mB0h00nWHWTHBq//G+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHJc8vrh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHJc8vrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89681C4CEFB;
	Thu, 18 Dec 2025 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766091613;
	bh=T0HudyPQiXlEcaSonXnq9yf2eOFygMh6mpUvZEIaQq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lHJc8vrhIoLAQtagdpMI10ecYbintFf8od6yiCak2iGx/eenO13Jhzwt12oYhfuUD
	 7pRi73KTbM7O87a0FYZ9KkoCr8ZaKbHyclVoSN36bDJ4IulzavdUiYctxaaCYQvC38
	 iguG9xUBawTeKSwfr9ZPpnIbtm239TlABUV2xE75rky3R4hX56nbNQt3nv1wT9mG4r
	 JREEUDsxSIEDBqhT0rvUBJVD1/eXhl6f2jUyKfI+CzAYWXXzLAHBJCsf7kG4sNGD3s
	 hOoc2rnylS8/LMN6QCOdqL3i4MUsY37qmT9yuC9rullkN6zPCAsTpqFVAQhQLHxRfy
	 zUWMoprBhWZdg==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Thu, 18 Dec 2025 21:59:45 +0100
Subject: [PATCH 2/2] docs: hacking: clarify reserved -EEXIST in
 module_init()
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dev-module-init-eexists-modules-docs-v1-2-361569aa782a@samsung.com>
References: <20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com>
In-Reply-To: <20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
 Lucas De Marchi <demarchi@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=da.gomez@samsung.com;
 h=from:subject:message-id; bh=3/juWpuVSytzeR+Q94yJU1Q00H8YiC2jNnM7Cj+uyis=;
 b=owEBbQKS/ZANAwAIAUCeo8QfGVH7AcsmYgBpRGtVjfIFrM2mvSEzkoG55N8iP84wo1gZ192UO
 GqVoRhx2xeJAjMEAAEIAB0WIQTvdRrhHw9z4bnGPFNAnqPEHxlR+wUCaURrVQAKCRBAnqPEHxlR
 +3HHD/92depapZq7iMsUsJXJdVEMKLcumRhNP+Nx/HM7u3b7B6t4zsBFoHqmPflmqwHtJpl1IcO
 7Fr9Q9JPGAV22731bBEo9m+GNH1wUyeSfjzAWddb7Cu+wwyosDL25NvuwPOdw4diVcYgQEPNrYM
 IDYoHJeqs0NSmMWmKSH3E5eytsnRFcjwDhvOQykxKqIMxJpAKetNEFuhjzCBEkaowpJUr5gzj8l
 L8TdROj4fgSTavRYw9bHMeBanjMQVxMZKlF1FWR7cK277hbNfWJAm30jzixpBHQ9mz9p4gADaPH
 wzn5Z4NmCwbNNspCchdE4qe8A9SaYdBXemdUEjDxJE9zKsO4KhqURfl7GpjN8X12vGDbnYuvtHK
 TefIgbYv0tCxh+GQu7QtKr+iHqPfmLKj5aXplshNXy0UidxJ/IKaOsHy9W4y3ynGPAFmf8dKbc+
 o8xWqEqaFKGfgDvKEMK5xAK2DG3nZnqPv0FcAD/wRkq3F9AGBOk/So77zEzwPfVh9zKYwEtJn4t
 Qb0GBlT5cLgXOQ3XxLmFyiQ2rk19g3ccCbvyPFcZL56mVCVTLAzJC9Qup87TTnLT6jSEIOda9B2
 dKwa3kaLjCQtB1rvoJqQ9GOtooQR1rApq2c+JuEZbaYPfRdmEA/z5x3z08CR3ye5/KMKr9x+Otf
 rpypRdw3Ux2jZYw==
X-Developer-Key: i=da.gomez@samsung.com; a=openpgp;
 fpr=B2A7A9CFDD03B540FF58B27185F56EA4E9E8138F

From: Daniel Gomez <da.gomez@samsung.com>

The error code -EEXIST is reserved by the kernel module loader to
indicate that a module with the same name is already loaded. Add
a warning note to clarify what these means for module authors and
maintainers to ensure the module_init() path return error do not
conflict with the reserved one.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 Documentation/kernel-hacking/hacking.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index 0042776a9e17..2c929ab93143 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -459,6 +459,13 @@ to fail (unfortunately, this has no effect if the module is compiled
 into the kernel). This function is called in user context with
 interrupts enabled, so it can sleep.
 
+.. warning::
+
+    The error code ``-EEXIST`` is reserved by the module loader to
+    indicate a module is already loaded. kmod interprets this as success,
+    so ``module_init()`` must never return ``-EEXIST``. Use ``-EBUSY`` or
+    ``-EALREADY`` instead.
+
 :c:func:`module_exit()`
 -----------------------
 

-- 
2.52.0

