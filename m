Return-Path: <lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
In-Reply-To: <878vc9s1tr.fsf@rustcorp.com.au>
References: <87obl9rsg2.fsf@rustcorp.com.au> <87ligdrscn.fsf@rustcorp.com.au>
 <CAMOw1v6Qy1wHhRcPQkyhDe7LrGaM_qRdhufr8YtHnfp5pTPFAA@mail.gmail.com> <878vc9s1tr.fsf@rustcorp.com.au>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 17 Sep 2012 14:37:23 -0300
Message-ID: <CAMOw1v6NE_CS63kCsfQ=kO8GdPpMzUi1+oyP97oq_DnV39ex1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: wait when loading a module which is currently initializing.
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Jon Masters <jonathan@jonmasters.org>,
	linux-modules <linux-modules@vger.kernel.org>, Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-modules.vger.kernel.org>

On Mon, Sep 17, 2012 at 1:36 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Lucas De Marchi <lucas.demarchi@profusion.mobi> writes:
>>> -       if (find_module(mod->name)) {
>>> +       if ((old = find_module(mod->name)) != NULL) {
>>> +               if (old->state == MODULE_STATE_COMING) {
>>> +                       /* Wait in case it fails to load. */
>>> +                       mutex_unlock(&module_mutex);
>>> +                       err = wait_event_interruptible(module_wq,
>>> +                                              finished_loading(mod->name));
>>> +                       if (err)
>>> +                               goto free_arch_cleanup;
>>> +                       goto again;
>>
>> I wonder if we should indeed retry in case the module failed to load
>> or if we should just skip straight to returning the error code. We
>> don't have the return code for the failed load, but maybe we can
>> fabricate one here.
>>
>> Thoughts?
>
> Could have different cmdline parameters, or other randomness like
> out-of-memory.  I think this is safest.

makes sense. Ack.

Lucas De Marchi
