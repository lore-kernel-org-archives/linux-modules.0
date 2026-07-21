Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7B43B3D2
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667442; cv=none; b=NvN8H9hOnQ8cJSKWxkt8B1a78aTBKB/qIyeWsPITi+m2wTaXgCnIyrVPxsSvEBu8rtldqx7c2Jebs1sKnQ+MPlJjIvN49kMUPWmLb+pCHQEjcaYRrssQ2F4CWJfbBcf+nt01ZcvSxUf83hakb2dgmK05WBHIpl4VoMbJPFVaoEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667442; c=relaxed/simple;
	bh=hS/jtkq/JrVHcN/uc/pVKASKGCENsolPn7B4mWKffAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XqaLcC1xs6G2t1V8q0Ch/McZHa3m2FKfZt/58sx3sO5pp60QlUuXImjo46bo8Fa7+9/Dqp2jNkv/7wcs8DmHk7hAAy9gkxSkGj3iNFy39pDPSA0I9UeyfvPTyO1Xxl1iy4ERjo2i1Knfid3qzEj/TyzA92rifv+TQFq6yIF6rx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsvaRuaE; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsvaRuaE"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb42a2f5feso4835222a34.1
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667437; x=1785272237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tICvvWUDLTcQaplMAJMGSX4sdCGxuxLlP7txV6x7Ef0=;
        b=BsvaRuaEa8t0WOpGhFUuzxV8ljunu9o+XdRcgrWLZ0DRZzmr7eUXRaHjWVheSrHxO+
         lRQ2n5USOyJU5CwSu+SycnU+yVf9DR7BPKGCfKGM1l8axIkN9bmwBElRC+8WpcGBZKsl
         cIC222LNGfeTtqNrpo29w+q+2L0yCTl/1JhVFM14zonVvsQ75oIKLQ9sjIpOdekI0uWq
         XKQTFTwBswVGi7kuAB60AjV0g/lRS32t159Z1utvx0jGnTrvkl3UrlvZb+PvvksqGavf
         +O/ywyOf0mGJM6/PcXIJ9wZnilhD/7vxqzjpytTn3UOQtlwf7Fw+vaqfNtLBMMJy7sRy
         bYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667437; x=1785272237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tICvvWUDLTcQaplMAJMGSX4sdCGxuxLlP7txV6x7Ef0=;
        b=rev6f7LuS46K3OS0dfHfn6L57nmkJyzsZK2l+5Tb4ftl9pKj9PkpyK73xpmpDBr0tB
         FNNDGhPgLYQnNkr3iZgyq1y64HA6T+8gdooVgxqYUY6Fp1g3g91VU+uLtMhi1UjDSMI+
         ByaZgfp9qx1NVcZ1bAmoZpnvL+yx0rgiKThbPlGGg5U3lWRBMhyUvQGNi5ScloAxSE9C
         u1tw1cJy3esMGrwXpHaCLn6b0j5nTrV7ulXN+7QtKhMPqgfxEHVzlkudakbK0Voq1jU/
         kdl0uX5L2G1RyfdBK/eRymvpOObdU/y1hFTQ72fKW9hbKDpslBvPKrz9tTPErOIJSqbe
         P7Tg==
X-Forwarded-Encrypted: i=1; AHgh+RqeKZ0bkuLNWAYh7M1pk/csDa1F0jsR6TTXTOuzvuEQeBgBaboPJb1Bjg4oK8dxV1ocaxPbLAv67KYEQ9lq@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ654CHu80Jx+hhUTMWCSppZFo1kc/bRxW7Xg2YiF2562oFpie
	zQP4MOdNiND2mMRSV9CckOQeRew9MpYPMUxDcZ5GkzV3XshqFoR/UF+g4jRWSg==
X-Gm-Gg: AfdE7ck/l26rn6RMhjPwCKpl03BVvkRfXFz5ypkyPYGJbazz71ifpWt8Rqi0+baBWN3
	ONoIy0RLLD/1DtzKNZ9VfVdBVdDeGeCPYejD0jrNOS5rMmVSv1U5poZJhsnAAiC2LIhNvFqSw5L
	u62fEXhojwVROqpmawLwoq88vwShkNbek+mM2vTdHr1akRfc+bDdmhZs4EKgXeXl9vuG/2uC9Ew
	I/sfPX8b7fCyVkMlvQRID5ZsT4aZqfq9Z9E2/YSM0HbhfpsrQsfPw/Gjzds3U6FUTEUT3Yz3mVp
	VCT9t6ZEvctLAQOsUD1AYK2nXm2pivPKS6adbCvGysXvpt6KCaExjxxpnG1KkLkQfo5ViSW9x5U
	t3Z1UxJSZxsW9qAnrA/4WT4VUKk4jJB76eIPNTCfGaV8VBp43AjkdKB4j2TF9n1kSWZrrw9d1E4
	zg0HLo8SxPTvtTtkF9ONCfUOFd202PG2a9/+jz8Ka20nqE4fdTijzyssiSRKdN/Io1fhsFzGqYJ
	7SCgLX3IwPzcAOddI0r58XMHQ==
X-Received: by 2002:a05:6830:3746:b0:7e6:c9eb:535a with SMTP id 46e09a7af769-7ed9aa4576emr10492097a34.6.1784667437350;
        Tue, 21 Jul 2026 13:57:17 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:54 -0600
Subject: [PATCH v7 05/29] drm: Mark CONFIG_DRM_USE_DYNAMIC_DEBUG as
 unBROKEN
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-5-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=924;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=hS/jtkq/JrVHcN/uc/pVKASKGCENsolPn7B4mWKffAg=;
 b=Lsf35FcMlCjbByxil/qjct2DAL4mr3Oc2q7x03tL/lqrAAMPWfcuP6gbFsC+oTgUeWP2YAwmG
 rTpFDD680+JBUtHGotBL8c4zwJWAzCGG1m6f1joIJBe2KBkLkyy1u+R
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Remove BROKEN mark on CONFIG_DRM_USE_DYNAMIC_DEBUG, inside
drivers/gpu/drm/Kconfig.debug.

Un-breaking the var allows to enable the config, and build and test
dynamic-debug-enabled DRM drivers with full classmap query support.

Doing this early in the commit-set exposes the series to more
in-series enabled testing, which has more chance to expose bugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 1f4c98cbf090..2ae59a616e75 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -1,7 +1,6 @@
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
 	default n
-	depends on BROKEN
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL

-- 
2.55.0

