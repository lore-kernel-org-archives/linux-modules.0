Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848F14658C
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405563; cv=none; b=pbqv06TKVvViHbpKv2MXC13A0S++r8B6f+nQLhDc2e6PcSBknnHpb1C5NflVHZpB0j1z9n2W1DTF/HlEPbocZ4tZ5f9i+6GLHWb+8pnVw6zsAhYMQk3nMZg+qF2Zdw5vffFA/PtBkDGQeYziKm2NIPU7+DPUxUSDF+NA5DLDAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405563; c=relaxed/simple;
	bh=UoI+ccD8HhCUWMF2aMaB3XNFhs9AFtClFMVC57QrS/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVFUrxeL8dyCB0bzD1wCvdFp2k9cslHMmeEZohdP3JwZivzHXX62kfTKwe70aDui0NNC1yKt2XM48jAuY1fJHFZtnq71w8U3FJBZ7j6ReDZuEtzIViw1M+e4ePTouK4CvMFB8XjSvN9mJ9ajK/VgcoiJlSC10p29AAi2OwDMZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ3Z7ieB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ3Z7ieB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A3F0C4AF0B;
	Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721405563;
	bh=UoI+ccD8HhCUWMF2aMaB3XNFhs9AFtClFMVC57QrS/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kJ3Z7ieBMvW+AYBuJ1Pla9YCzPlLMW08QH3JfPDRt4fbn7N/sjw4tSJqbRgy5mEWH
	 wICr+dw9Uk+MherVAYz3gu37bIdVE07fq5LjEZ7jh0x7OF9bYLdYJBiFMX3lYOV6jq
	 rnKFpJzsYSUb3seoCmSQlfZnfgXnspRJMZpLZyPClN2NYFqZD63/5vAzf2+GL3DJAu
	 t1e0gHEpGHFRuQgF/XfsEzmvwGkIf8Aufh64/JMGIfIKHBn3bqSsNoi01H2MQyXzdM
	 WKSOtTECQ7/B1kIgjgamcS+SRtvOJcRqSmZXaNe4//+IKbpf4WvHUkXY+XTeg9Ku/G
	 +LVpXLghBHLZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A5BC3DA70;
	Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 19 Jul 2024 17:12:43 +0100
Subject: [PATCH kmod 3/3] libkmod: move new weak API to separate section
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-abi-fixes-v1-3-1e6d99a2846b@gmail.com>
References: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
In-Reply-To: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Marco d'Itri <md@linux.it>, Eugene Syromiatnikov <esyr@redhat.com>, 
 Josh Boyer <jwboyer@fedoraproject.org>, 
 Yauheni Kaliuta <ykaliuta@fedoraproject.org>, 
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, 
 Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405562; l=1334;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=vGLxbr7hhKT9ywrDmQYwW4P0+rL1j1tEnx5Lr/UUei0=;
 b=HkChS8BpMWSSsXkfB88Of9BJ3gC2qimdMCLTgfjlqyPIHnrwE1GaU/SjNRxecEZUABX/Y2HTE
 k1drtkMMPJeC8heA5dbSw7qoJsPjIGAhOqS0BbBnvaReZ5moP7k4IFK
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Add the new weak API, to a separate section in the version script. These
will be exposed with the upcoming v33 release and not with v5 as the
symbol tag implies.

Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Fixes: 05828b4 ("libkmod: add weak dependecies")
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
This might be a bit of nuisance for Debian which has a git packages in
unstable.

@Marco I think you'd _really_ want this for unstable.
---
 libkmod/libkmod.sym | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod.sym b/libkmod/libkmod.sym
index e71f488..0046300 100644
--- a/libkmod/libkmod.sym
+++ b/libkmod/libkmod.sym
@@ -21,7 +21,6 @@ global:
 	kmod_config_get_aliases;
 	kmod_config_get_options;
 	kmod_config_get_softdeps;
-	kmod_config_get_weakdeps;
 	kmod_config_iter_get_key;
 	kmod_config_iter_get_value;
 	kmod_config_iter_next;
@@ -42,7 +41,6 @@ global:
 
 	kmod_module_get_dependencies;
 	kmod_module_get_softdeps;
-	kmod_module_get_weakdeps;
 	kmod_module_get_filtered_blacklist;
 
 	kmod_module_get_name;
@@ -98,3 +96,9 @@ LIBKMOD_30 {
 global:
 	kmod_module_new_from_name_lookup;
 } LIBKMOD_22;
+
+LIBKMOD_33 {
+global:
+	kmod_config_get_weakdeps;
+	kmod_module_get_weakdeps;
+} LIBKMOD_30;

-- 
2.45.2


