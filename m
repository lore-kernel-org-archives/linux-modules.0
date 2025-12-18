Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938533A9D2;
	Thu, 18 Dec 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091611; cv=none; b=l0/PIQRGciYpAaqNDFsQPTXYdap4LgS3QOKzX5PDmBekgEIFN/mgwAKgS7Y4/JlUVoUZVsQgOwDen7AraEG7jzE/Ao7VrKM8zqTuVriUumdKvYHftY/64lFzFWHBsoRbB+UmOE+1kXTSd5g+suyKQBWa0H5RNdOO3e2ivPBIXvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091611; c=relaxed/simple;
	bh=b0KBXZU1l1tjWXLTckjL6wIhQJEHgxGVlrwheNqDpyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JdLNOYhSTLyAeZmgz2UPROm6X5gT2zCYp5IMd7UR9qsdWucomwgHfO2QAgyG7hG4ZXfVcelqCPQbroC6rRsJ+ZbeylhMu1L/YTinCtipRweWT91X/RyHdEqcC5FxQ9g4P0D857xuPeRQHmOvzw3jELi4vk/rThRDfse0kQ8xBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAdhssyi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAdhssyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29603C116D0;
	Thu, 18 Dec 2025 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766091611;
	bh=b0KBXZU1l1tjWXLTckjL6wIhQJEHgxGVlrwheNqDpyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XAdhssyi6bZ01Qk01YeSQ8zw4oYaNvzysiHnZTMNdkO8RpeTNTGxFWlCPdKye8nnF
	 5zLm5AM8q30D4gEb/6MSSVhl9Ku5P25GAwddCyTJKuzC1TUAyvG4ssGUVOAT8+Vm9u
	 EQSaAZEM1CdRx1zQxpc2pzQyVoVfEIyc/f30vcZkn9IYrD60jD7q4b4uYvT1myIUY0
	 qPD6wJTq/z0HszHZ+cg7lZlfE3hVf6f+5ke1KYbPDNkKYWjpyFzMDxcASnKifDdZ0h
	 syd53/ful/1ZYJyCNUmJB16DUHfVVcQCqcnc6zXA9j2IwxsdENECoLektU4hN5VoDJ
	 s5bfGBIXA4m9g==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Thu, 18 Dec 2025 21:59:44 +0100
Subject: [PATCH 1/2] module: add -EEXIST documentation
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dev-module-init-eexists-modules-docs-v1-1-361569aa782a@samsung.com>
References: <20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com>
In-Reply-To: <20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
 Lucas De Marchi <demarchi@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=da.gomez@samsung.com;
 h=from:subject:message-id; bh=hP58waUaaD3eZ5jAC5SvBWbgesYb/Es043tMEuXEBZk=;
 b=owEBbQKS/ZANAwAIAUCeo8QfGVH7AcsmYgBpRGtTfq3ytmmB6MomNA4lbtFq4UGIkg7WuBYKg
 89EKDK9YleJAjMEAAEIAB0WIQTvdRrhHw9z4bnGPFNAnqPEHxlR+wUCaURrUwAKCRBAnqPEHxlR
 +2OQD/9s2rIn76bZZ/s0qxfC/HmOf724NEBHN79Ut9PlZPKQU3iWMuYGbrHGMF3o1jhQWZo9zNF
 yVGpTL0DBF8j0lrY/2vXi3JD08yWuVVotAQ1HPfasphVsbebf+c6utKjL6jonkGNLImPGlQlqE1
 m5f1zYs0xgANZMtVRz60I6QevcxAoFqIYkLgIDi3hVKspLd/3vam2RVj2+B5z32kvtz8W/UjPFZ
 b7is3raBp7KjppdwI539SVuBXQK9uwB3PI4N8IHu5p0gz3Wbdnmp6+D1mZRXLPLtrn/toJXAEYD
 9fP5NS38JUB6HOE2Cn6GHqh7yPEo66YwMtfrAQ7NPlan+HJQXCfbFLToKblJrW7yQagsqfBCnn6
 TH19N36Akmnxne1mNMDcku5gFhpNm4U6TgKx2uR1ssvFOJzKHVSwSwxxDHKWe4L5gjBJ3KQZSnr
 wWnrgyUiDtF7u43EIn6XBGfCE3ahptj33SZvUYcMmS4i7xv0u1s2PYgJUYU3Wlf9EG1P1rjWXcz
 Epy1LQpH4MApkU8eSAiJhaukXbUkgJLCSlMHfQ2PsHLfEAAb8Sdje+p+Z0rsqXlFwoSk6mRzeUj
 RjZRiaeAauZ6B/h97w2fqCnjEWhI/xWbJbk43L7hAbC2pad2LvBl0MzAnynK3nkmj/5EJsAkRie
 obMvPGBMikILG2w==
X-Developer-Key: i=da.gomez@samsung.com; a=openpgp;
 fpr=B2A7A9CFDD03B540FF58B27185F56EA4E9E8138F

From: Daniel Gomez <da.gomez@samsung.com>

The error code -EEXIST is reserved by the kernel module loader to
indicate that a module with the same name is already loaded. Add a
comment to clarify what this means for module authors and maintainers
to ensure the module_init() path return error do not conflict with the
reserved one.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 kernel/module/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a8394d81174f..655a780981d3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3038,6 +3038,14 @@ static noinline int do_init_module(struct module *mod)
 	if (mod->init != NULL)
 		ret = do_one_initcall(mod->init);
 	if (ret < 0) {
+		/*
+		 * -EEXIST is reserved by the module loader to mean "already loaded". kmod
+		 * interprets this as success, hiding real module failures. Override with
+		 * -EBUSY and warn.
+		 *
+		 * Module authors: use -EBUSY or -EALREADY instead of -EEXIST.
+		 * See Documentation/kernel-hacking/hacking.rst
+		 */
 		if (ret == -EEXIST) {
 			pr_warn("%s: init suspiciously returned -EEXIST: Overriding with -EBUSY\n",
 				mod->name);

-- 
2.52.0

