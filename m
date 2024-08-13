Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB217CA02
	for <linux-modules@vger.kernel.org>; Tue, 13 Aug 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558686; cv=none; b=Xqz5ddFE+rAnfCd3JFm76YUxEY2krIFJT/SwqMuo4tfpnKc6AgAG2jaIGCh1khv1Ex+Es22zf9AUMqNNUoOyy/RxC0HRNpBah/HCExzJPYIeaiWhTAF43mozMWgwdlYJrWkDcQL1dgpdmCL0vQZsYlmVpik3NEqEMstlPfHWzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558686; c=relaxed/simple;
	bh=1R/Vf1sSjnNdpyRGjLdxbDm7RpMd9xq0t4elFI3VW6Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J2olp5ttZGor/I63Mx7PSNWu7tn9VSc2a3ADI+e2S1Hoy5QNuUchks+5h3hpjo00388CXU4bweUrP/4CDze5l+h6sVru6A1VH2+xE72TiprxwURXYmao0t8zRF6b2ruZbd9rwy4ZODyYB9xHYx4VezFzX42mXm2UojFmQtyxeuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibi39TwA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibi39TwA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723558684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CjnP2fPrB2GRvTtR73wDZQcDl2q4J4wX/QDMBTJEfa4=;
	b=ibi39TwAdZ8K362WmZHlbWhUvir3LmtLI9GCfMOXvJQ/MaPpnxe53EffJbfqRGa2LTIkuO
	o+IdFG+18ffrPcs3nCA+ZQyTxoUM17VhR2y0HlLGcbxKmeVqsaXwOsxPc6tjDQ1zB3gAYj
	B+XhszAZJ9E0EG1N4LXaYDrCZh8Z/Ps=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-2MuPdoYAOyeX8pbJWARmuQ-1; Tue,
 13 Aug 2024 10:18:02 -0400
X-MC-Unique: 2MuPdoYAOyeX8pbJWARmuQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E630318EA80B
	for <linux-modules@vger.kernel.org>; Tue, 13 Aug 2024 14:18:01 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E5E41932DBB
	for <linux-modules@vger.kernel.org>; Tue, 13 Aug 2024 14:17:31 +0000 (UTC)
Date: Tue, 13 Aug 2024 16:17:27 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH kmod] libkmod: avoid undefined behaviour in
 libkmod-builtin.c:get_string
Message-ID: <20240813141727.GA23657@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Static analysis has reported a potential UB:

    kmod-31/libkmod/libkmod-builtin.c:125: use_invalid: Using "nullp", which points to an out-of-scope variable "buf".
    #  123|   	size_t linesz = 0;
    #  124|
    #  125|-> 	while (!nullp) {
    #  126|   		char buf[BUFSIZ];
    #  127|   		ssize_t sz;

It seems to be indeed an UB, as nullp is getting assined an address
inside object buf, which has a lifetime of the while loop body,
and is not available outside of it (specifically, in the while
condition, where nullp is checked for NULL).  Fix it by putting
buf definition in the outer block.
---
 libkmod/libkmod-builtin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
index fd0f54923a48..40a7d6142d03 100644
--- a/libkmod/libkmod-builtin.c
+++ b/libkmod/libkmod-builtin.c
@@ -105,11 +105,11 @@ static off_t get_string(struct kmod_builtin_iter *iter, off_t offset,
 			char **line, size_t *size)
 {
 	int sv_errno;
+	char buf[BUFSIZ];
 	char *nullp = NULL;
 	size_t linesz = 0;
 
 	while (!nullp) {
-		char buf[BUFSIZ];
 		ssize_t sz;
 		size_t partsz;
 
-- 
2.28.0

