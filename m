Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8C2C6BD
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118304; cv=none; b=uyMiys5f/2tcxz55VMi7G3rrQm1U48w8yfuJYo5s37VibqWBC1nTsOhNaxjiA3Q9WLDsj056Vl3ZVGZBtDtYWIeBRdkeYk+cC+Do3EvG1vghQUwl2v1aeEZEQtu+n2gJxqHU1MHa7xlBDSV67RHS00trydMJivLeyXzMbrIfY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118304; c=relaxed/simple;
	bh=tj0XOGBSzmoJZInyyhmovkdJ4bOXtedRihkqHVH1Pzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5W36v4WpC2/mcU9HmlKFKSolsqsxCbh8XKsUN5L8HnMgR8TB4PZ/Gp+6PZx3Mq/zKHrM/EEfUBTzqkhSF9S1/Nwk2x3Nmoe2goriF49S21Mj9muCkL5eam0Nzxhb0vl5ghzWvc+zilBtjQvR541XImF+IMF3MQCM9oYnNPIecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phjsyapx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phjsyapx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E935C2BD10;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118304;
	bh=tj0XOGBSzmoJZInyyhmovkdJ4bOXtedRihkqHVH1Pzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PhjsyapxPxufqGwn8MUNtuoY1L5yZDz2+IUTL3CXhA82nWUtUaeZgENkyIWD6+b9A
	 9sl2ZL91166whfTk4e3669Gdi9Dp1lyvCpNqxjffKsjWCEHpm6fAlGU6LMGhHPvBX0
	 dayzVLALH8lalDYFstfBzRsbPIdyJLfSWF59mUElUqGAyuvZ7XPwwyGi1KkQUovbNU
	 FT+rChb5nUDPrFkYuNDQI68+1G4Yn8liIoEyORSuTBfHklS/wnW6MWJA03fwHQTVxQ
	 /Wmb025xBmNNwAcKwZ7pT9PdQIuBJa8Js0so2cuEDHKZBiQyjSg/YpQA71TG4FIHuL
	 hUmSBB3EKJCRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BCC27C77;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:01 +0100
Subject: [PATCH kmod 01/20] man: add script to generate/compare the xslt vs
 upcoming scdoc
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-1-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=1480;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=wl8y3cCAXvkyBcYxfCkLgOSs/6n6t5ifCxlBs/k7x6I=;
 b=Lo2mmoP5zfrYdpxqFhJA2HGysoY+JMSnam2FhSYYf+v4tmMS4fpr7t0pb73yVlWbI681n33Xb
 kRG6S655KCKCnsKQAam275T186SdStufp6n66SySItkII75tliGR13V
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/compare.sh | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/man/compare.sh b/man/compare.sh
new file mode 100755
index 0000000..7579ab5
--- /dev/null
+++ b/man/compare.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+
+the_sed()
+{
+	sed -e 's|@DISTCONFDIR@|/TEST|g;s|@MODULE_DIRECTORY@|/TEST|g' $1
+}
+
+gen_xslt()
+{
+			#--output ${xml//.xml}.xslt \
+			#--noout \
+	for xml in *xml; do
+		the_sed $xml | xsltproc \
+			--stringparam man.output.quietly 1 \
+			--param funcsynopsis.style "'ansi'" \
+			http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl -
+		# The output and noout args seems cosmetic, sigh
+		mv ${xml//.xml}{,.xslt}
+	done
+}
+
+gen_scdoc()
+{
+	for scd in *scd; do
+		the_sed $scd | scdoc > ${scd//.scd}.scdoc
+	done
+}
+
+comp_output()
+{
+	export LESS='-F -i -M -R -S -w -X -z-4'
+	unset MANPAGER
+
+	for xslt in $(ls --sort=version *xslt); do
+		_name=${xslt//.xslt}
+
+		echo "Checking $_name"
+
+		diff --unified --color=always \
+			<(man ./$_name.xslt) \
+			<(man ./$_name.scdoc) | less
+
+		read
+	done
+}
+
+comp_raw()
+{
+	for xslt in *xslt; do
+		_name=${xslt//.xslt}
+
+		diff --unified --color=always ./$_name.{xslt,scdoc}
+	done
+}
+
+time gen_xslt
+time gen_scdoc
+
+comp_output
+#comp_raw
+
+rm -f *xslt
+rm -f *scdoc

-- 
2.45.0


