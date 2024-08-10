Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3C15821D
	for <linux-modules@vger.kernel.org>; Sat, 10 Aug 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723292727; cv=none; b=i5Rnw3sygfXicVr4hu1+tREv9noZUbo0oSoPFS06K5ppsivABWbQNqsaQ/ygoKF7czvqC5HTvvfPUnmWRDzwc4U2hyzAkL7wDnu/zwX1nqm4X1ZtsiLhPrk58AN24FpoBloFzAvK3P+6P35aG2ApIHOA/wYjzGaHJ4EuORN7Kr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723292727; c=relaxed/simple;
	bh=jlUDiMNZE7T9SGMxkBYqlp6Ls3ZlAcUecsx7jQktNmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SqnMNWTYkpN4y0i/qI3eGG+39ya+dyccC/qZP8PTgkpX1wqIKXohCBtL8TIfm1gCxFlMfrWS6j5dCPkttXDMM+NiURtLblXYJRzkk7cPJ4YtjhpsO2Wes4x3PhtVB4crJqGhjaPH7F6J0yNkIWTYyBVnoUxrmmbdiQ0cakh0mHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEYSWaS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEYSWaS/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BF35C4AF0D;
	Sat, 10 Aug 2024 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723292727;
	bh=jlUDiMNZE7T9SGMxkBYqlp6Ls3ZlAcUecsx7jQktNmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AEYSWaS/rBSbHLQFmPxUd8bsulXFpggCL/AmtRRFtdGhR6I1G0uHHZqD96ppxKPFk
	 oQOc4ae12J+MWEhZRhnwrkaWme3TsGgE17W8IHsb5cycebqOk0zpwzyIXjmazsup4Q
	 Uc/yoLsaSn/Foao+LC2dYJCaYv14ocY6wVLM/Q1BFrNRm/+xdDPBKywtdZ59W+AeQ/
	 utCW0Ztjm1MzvjCYdZJ9Gfot6zss+meMssZYpIGRvxz0dWNdQ9KQuXhjr9D7a3Vx9G
	 Tz2u60bWruJdStSW8EvBjgiiMDLFvzHq/hcqfdmDyX3BbrrpDHSWJ8MkSujuhF8a2n
	 /0a8NVRlhnDLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2E2C3DA4A;
	Sat, 10 Aug 2024 12:25:27 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Sat, 10 Aug 2024 13:25:15 +0100
Subject: [PATCH kmod 1/2] m4: reinstate CC_CHECK_FLAG_APPEND summary
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240810-b4-spdx-fixup-v1-1-b9c84d637fb3@gmail.com>
References: <20240810-b4-spdx-fixup-v1-0-b9c84d637fb3@gmail.com>
In-Reply-To: <20240810-b4-spdx-fixup-v1-0-b9c84d637fb3@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, 
 Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723292726; l=1027;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=AF5iab6GulDH6KmEHj4ODm9E17GVEFRi9ewJjoqAJxU=;
 b=Ls03SQmbnebXlYWpWG9+yJ9PaeeS0fQ2iuxdZkWLxtXon5xzBQeH2P3n0VdRbGzrgBvGqLlEW
 tr3YjJ/YwLsBfzTvOTYSpWeSVTU19XpxkVis9f/AbExN5Zl2tEA+n0Q
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Earlier commit was reducing the license boilerplate to SPDX license
identifiers and erroneously dropped the function summary section.

Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Fixes: b5a2cd0 ("Use SPDX header for license")
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 m4/attributes.m4 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/m4/attributes.m4 b/m4/attributes.m4
index 69865ee..a22bb58 100644
--- a/m4/attributes.m4
+++ b/m4/attributes.m4
@@ -4,6 +4,11 @@
 # Copyright (c) 2006-2008 xine project
 # Copyright (c) 2012 Lucas De Marchi <lucas.de.marchi@gmail.com>
 
+# Check if FLAG in ENV-VAR is supported by compiler and append it
+# to WHERE-TO-APPEND variable. Note that we invert -Wno-* checks to
+# -W* as gcc cannot test for negated warnings.
+# CC_CHECK_FLAG_APPEND([WHERE-TO-APPEND], [ENV-VAR], [FLAG])
+
 AC_DEFUN([CC_CHECK_FLAG_APPEND], [
   AC_CACHE_CHECK([if $CC supports flag $3 in envvar $2],
                  AS_TR_SH([cc_cv_$2_$3]),

-- 
2.45.2


