Return-Path: <SRS0=JIew=N5=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07961C43441
	for <linux-modules@archiver.kernel.org>; Sun, 18 Nov 2018 07:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C327B2080F
	for <linux-modules@archiver.kernel.org>; Sun, 18 Nov 2018 07:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C327B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeKRSO3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 18 Nov 2018 13:14:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeKRSO3 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sun, 18 Nov 2018 13:14:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12C1E4E90E;
        Sun, 18 Nov 2018 07:54:57 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 327E05D75D;
        Sun, 18 Nov 2018 07:54:55 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH] libkmod-signature: implement pkcs7 parsing with openssl
In-Reply-To: <20181116183228.32080-1-yauheni.kaliuta@redhat.com> (Yauheni
        Kaliuta's message of "Fri, 16 Nov 2018 20:32:28 +0200")
References: <20181116183228.32080-1-yauheni.kaliuta@redhat.com>
Date:   Sun, 18 Nov 2018 09:54:55 +0200
Message-ID: <xunyzhu6izw0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 18 Nov 2018 07:54:57 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi!

>>>>> On Fri, 16 Nov 2018 20:32:28 +0200, Yauheni Kaliuta  wrote:


[...]

Yeah, cleanup on error for the values allocated below.

But the main question is in general if the way of linking is
possible.

 > +
 > +
 > +	sno_bn = ASN1_INTEGER_to_BN(sno, NULL);
 > +	if (sno_bn == NULL)
 > +		goto err;
 > +
 > +	len = BN_num_bytes(sno_bn);
 > +	key_id_str = malloc(len);
 > +	BN_bn2bin(sno_bn, key_id_str);
 > +
 > +	sig_info->key_id = (const char *)key_id_str;
 > +	sig_info->key_id_len = len;
 > +
 > +	issuer_str = x509_name_to_str(issuer);
 > +	if (issuer_str != NULL) {
 > +		sig_info->signer = issuer_str;
 > +		sig_info->signer_len = strlen(issuer_str);
 > +	}
 > +
 > +	sig_info->algo = NULL;
 > +
 > +	X509_ALGOR_get0(&o, NULL, NULL, dig_alg);
 > +
 > +	sig_info->hash_algo = pkey_hash_algo[obj_to_hash_algo(o)];
 > +	sig_info->id_type = pkey_id_type[modsig->id_type];
 > +
 > +	pvt = malloc(sizeof(*pvt));
 > +	if (pvt == NULL)
 > +		goto err;
 > +
 > +	pvt->cms = cms;
 > +	pvt->key_id = key_id_str;
 > +	pvt->sno = sno_bn;
 > +	sig_info->private = pvt;
 > +
 > +	sig_info->free = pkcs7_free;
 > +
 > +	return true;
 > +
 > +err:
 > +	CMS_ContentInfo_free(cms);
 > +	return false;
 > +}
 > +


-- 
WBR,
Yauheni Kaliuta
