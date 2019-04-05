{*
 +--------------------------------------------------------------------+
 | CiviCRM version 5                                                  |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2019                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
<div class="crm-block crm-content-block crm-contribution-view-form-block">
<div class="action-link">
  <div class="crm-submit-buttons">
    {if (call_user_func(array('CRM_Core_Permission','check'), 'edit contributions') && call_user_func(array('CRM_Core_Permission', 'check'), "edit contributions of type $financial_type") && $canEdit) ||
    	(call_user_func(array('CRM_Core_Permission','check'), 'edit contributions') && $noACL)}
      {assign var='urlParams' value="reset=1&id=$id&cid=$contact_id&action=update&context=$context"}
      {if ( $context eq 'fulltext' || $context eq 'search' ) && $searchKey}
        {assign var='urlParams' value="reset=1&id=$id&cid=$contact_id&action=update&context=$context&key=$searchKey"}
      {/if}
      <a class="button" href="{crmURL p='civicrm/contact/view/contribution' q=$urlParams}" accesskey="e"><span>
          <i class="crm-i fa-pencil"></i> {ts}Edit{/ts}</span>
      </a>
      {if $paymentButtonName}
        <a class="button" href='{crmURL p="civicrm/payment" q="action=add&reset=1&component=`$component`&id=`$id`&cid=`$contact_id`"}'><i class="crm-i fa-plus-circle"></i> {ts}{$paymentButtonName}{/ts}</a>
      {/if}
    {/if}
    {if (call_user_func(array('CRM_Core_Permission','check'), 'delete in CiviContribute') && call_user_func(array('CRM_Core_Permission', 'check'), "delete contributions of type $financial_type") && $canDelete)     || (call_user_func(array('CRM_Core_Permission','check'), 'delete in CiviContribute') && $noACL)}
      {assign var='urlParams' value="reset=1&id=$id&cid=$contact_id&action=delete&context=$context"}
      {if ( $context eq 'fulltext' || $context eq 'search' ) && $searchKey}
        {assign var='urlParams' value="reset=1&id=$id&cid=$contact_id&action=delete&context=$context&key=$searchKey"}
      {/if}
      <a class="button" href="{crmURL p='civicrm/contact/view/contribution' q=$urlParams}"><span>
          <i class="crm-i fa-trash"></i> {ts}Delete{/ts}</span>
      </a>
    {/if}
    {include file="CRM/common/formButtons.tpl" location="top"}
    {assign var='pdfUrlParams' value="reset=1&id=$id&cid=$contact_id"}
    {assign var='emailUrlParams' value="reset=1&id=$id&cid=$contact_id&select=email"}
    {if $invoicing}
      <div class="css_right">
        <a class="button no-popup" href="{crmURL p='civicrm/contribute/invoice' q=$pdfUrlParams}">
          <i class="crm-i fa-print"></i>
        {if $contribution_status != 'Refunded' && $contribution_status != 'Cancelled' }
          {ts}Print Invoice{/ts}</a>
        {else}
          {ts}Print Invoice and Credit Note{/ts}</a>
        {/if}
        <a class="button" href="{crmURL p='civicrm/contribute/invoice/email' q=$emailUrlParams}">
          <i class="crm-i fa-paper-plane"></i>
          {ts}Email Invoice{/ts}</a>
      </div>
    {/if}
  </div>
</div>
<table class="crm-info-panel">
  {if $is_test}
    <div class="help">
      <strong>{ts}This is a TEST transaction{/ts}</strong>
    </div>
  {/if}
  <tr class="crm-contribute-contributionview-form-block-displayName">
    <td class="label">{ts}From{/ts}</td>
    <td class="bold"><a href="{crmURL p='civicrm/contact/view' q="cid=$contact_id"}">{$displayName}</a></td>
  </tr>
  <tr class="crm-contribute-contributionview-form-block-is_test">
    <td class="label">{ts}Financial Type{/ts}</td>
    <td>{$financial_type}{if $is_test} {ts}(test){/ts} {/if}</td>
  </tr>
  {if $displayLineItems}
    <tr class="crm-contribute-contributionview-form-block-displayLineItems">
      <td class="label">{ts}Contribution Amount{/ts}</td>
      <td>{include file="CRM/Price/Page/LineItem.tpl" context="Contribution"}
        {if $contribution_recur_id}
          <strong>{ts}Recurring Contribution{/ts}</strong>
          <br/>
          {ts}Installments{/ts}: {if $recur_installments}{$recur_installments}{else}{ts}(ongoing){/ts}{/if}, {ts}Interval{/ts}: {$recur_frequency_interval} {$recur_frequency_unit}(s)
        {/if}
      </td>
    </tr>
  {else}
    <tr class="crm-contribute-contributionview-form-block-total_amount">
      <td class="label">{ts}Total Amount{/ts}</td>
      <td><strong>{$total_amount|crmMoney:$currency}</strong>
        {if $contribution_recur_id}
          <a class="crm-hover-button" href='{crmURL p="civicrm/contact/view/contributionrecur" q="reset=1&id=`$contribution_recur_id`&cid=`$contact_id`&context=contribution"}'>
            <strong>{ts}Recurring Contribution{/ts}</strong>
          </a>
          <br/>
          {ts}Installments{/ts}: {if $recur_installments}{$recur_installments}{else}{ts}(ongoing){/ts}{/if}, {ts}Interval{/ts}: {$recur_frequency_interval} {$recur_frequency_unit}(s)
        {/if}
      </td>
    </tr>
  {/if}
  {if $invoicing && $tax_amount}
    <tr class="crm-contribute-contributionview-form-block-taxAmount">
      <td class="label">{ts 1=$taxTerm}Total %1 Amount{/ts}</td>
      <td>{$tax_amount|crmMoney:$currency}</td>
    </tr>
  {/if}
  {if $non_deductible_amount}
    <tr class="crm-contribute-contributionview-form-block-non_deductible_amount">
      <td class="label">{ts}Non-deductible Amount{/ts}</td>
      <td>{$non_deductible_amount|crmMoney:$currency}</td>
    </tr>
  {/if}
  {if $fee_amount}
    <tr class="crm-contribute-contributionview-form-block-fee_amount">
      <td class="label">{ts}Fee Amount{/ts}</td>
      <td>{$fee_amount|crmMoney:$currency}</td>
    </tr>
  {/if}
  {if $net_amount}
    <tr class="crm-contribute-contributionview-form-block-net_amount">
      <td class="label">{ts}Net Amount{/ts}</td>
      <td>{$net_amount|crmMoney:$currency}</td>
    </tr>
  {/if}
  {if $isDeferred AND $revenue_recognition_date}
    <tr class="crm-contribute-contributionview-form-block-revenue_recognition_date">
      <td class="label">{ts}Revenue Recognition Date{/ts}</td>
      <td>{$revenue_recognition_date|crmDate:"%B, %Y"}</td>
    </tr>
  {/if}
  <tr class="crm-contribute-contributionview-form-block-receive_date">
    <td class="label">{ts}Received{/ts}</td>
    <td>{if $receive_date}{$receive_date|crmDate}{else}({ts}not available{/ts}){/if}</td>
  </tr>
  {if $to_financial_account }
    <tr class="crm-contribute-contributionview-form-block-to_financial_account">
      <td class="label">{ts}Received Into{/ts}</td>
      <td>{$to_financial_account}</td>
    </tr>
  {/if}
  <tr class="crm-contribute-contributionview-form-block-contribution_status_id">
    <td class="label">{ts}Contribution Status{/ts}</td>
    <td {if $contribution_status_id eq 3} class="font-red bold"{/if}>{$contribution_status}
      {if $contribution_status_id eq 2} {if $is_pay_later}: {ts}Pay Later{/ts} {else} : {ts}Incomplete Transaction{/ts} {/if}{/if}</td>
  </tr>

  {if $cancel_date}
    <tr class="crm-contribute-contributionview-form-block-cancel_date">
      <td class="label">{ts}Cancelled / Refunded Date{/ts}</td>
      <td>{$cancel_date|crmDate}</td>
    </tr>
    {if $cancel_reason}
      <tr class="crm-contribute-contributionview-form-block-cancel_reason">
        <td class="label">{ts}Cancellation / Refund Reason{/ts}</td>
        <td>{$cancel_reason}</td>
      </tr>
    {/if}
    {if $refund_trxn_id}
      <tr class="crm-contribute-contributionview-form-block-refund_trxn_id">
        <td class="label">{ts}Refund Transaction ID{/ts}</td>
        <td>{$refund_trxn_id}</td>
      </tr>
    {/if}
  {/if}
  <tr class="crm-contribute-contributionview-form-block-payment_instrument">
    <td class="label">{ts}Payment Method{/ts}</td>
    <td>{$payment_instrument}{if $payment_processor_name} ({$payment_processor_name}){/if}</td>
  </tr>

  {if $payment_instrument eq 'Check'|ts}
    <tr class="crm-contribute-contributionview-form-block-check_number">
      <td class="label">{ts}Check Number{/ts}</td>
      <td>{$check_number}</td>
    </tr>
  {/if}
  <tr class="crm-contribute-contributionview-form-block-source">
    <td class="label">{ts}Source{/ts}</td>
    <td>{$source}</td>
  </tr>

  {if $campaign}
    <tr class="crm-contribute-contributionview-form-block-campaign">
      <td class="label">{ts}Campaign{/ts}</td>
      <td>{$campaign}</td>
    </tr>
  {/if}

  {if $contribution_page_title}
    <tr class="crm-contribute-contributionview-form-block-contribution_page_title">
      <td class="label">{ts}Online Contribution Page{/ts}</td>
      <td>{$contribution_page_title}</td>
    </tr>
  {/if}
  {if $receipt_date}
    <tr class="crm-contribute-contributionview-form-block-receipt_date">
      <td class="label">{ts}Receipt Sent{/ts}</td>
      <td>{$receipt_date|crmDate}</td>
    </tr>
  {/if}
  {foreach from=$note item="rec"}
    {if $rec }
      <tr class="crm-contribute-contributionview-form-block-note">
        <td class="label">{ts}Note{/ts}</td>
        <td>{$rec}</td>
      </tr>
    {/if}
  {/foreach}

  {if $trxn_id}
    <tr class="crm-contribute-contributionview-form-block-trxn_id">
      <td class="label">{ts}Transaction ID{/ts}</td>
      <td>{$trxn_id}</td>
    </tr>
  {/if}

  {if $invoice_number}
    <tr class="crm-contribute-contributionview-form-block-invoice_number">
      <td class="label">{ts}Invoice Number{/ts}</td>
      <td>{$invoice_number}&nbsp;</td>
    </tr>
  {/if}

  {if $invoice_id}
    <tr class="crm-contribute-contributionview-form-block-invoice_id">
      <td class="label">{ts}Invoice Reference{/ts}</td>
      <td>{$invoice_id}&nbsp;</td>
    </tr>
  {/if}

  {if $thankyou_date}
    <tr class="crm-contribute-contributionview-form-block-thankyou_date">
      <td class="label">{ts}Thank-you Sent{/ts}</td>
      <td>{$thankyou_date|crmDate}</td>
    </tr>
  {/if}
  <tr class="crm-contribute-contributionview-form-block-payment_details">
    <td class="label">{ts}Payment Details{/ts}</td>
    <td>{include file="CRM/Contribute/Form/PaymentInfoBlock.tpl"}</td>
  </tr>
  {if $addRecordPayment}
    <tr class="crm-contribute-contributionview-form-block-payment_info">
      <td class='label'>{ts}Payment Summary{/ts}</td>
      <td id='payment-info'></td>
    </tr>
  {/if}
</table>

{if $softContributions && count($softContributions)} {* We show soft credit name with PCP section if contribution is linked to a PCP. *}
  <div class="crm-accordion-wrapper crm-soft-credit-pane">
    <div class="crm-accordion-header">
      {ts}Soft Credit{/ts}
    </div>
    <div class="crm-accordion-body">
      <table class="crm-info-panel crm-soft-credit-listing">
        {foreach from=$softContributions item="softCont"}
          <tr class="crm-contribute-contributionview-form-block-softContributions">
            <td>
              <a href="{crmURL p="civicrm/contact/view" q="reset=1&cid=`$softCont.contact_id`"}"
                 title="{ts}View contact record{/ts}">{$softCont.contact_name}
              </a>
            </td>
            <td>{$softCont.amount|crmMoney:$currency}
              {if $softCont.soft_credit_type_label}
                ({$softCont.soft_credit_type_label})
              {/if}
            </td>
          </tr>
        {/foreach}
      </table>
    </div>
  </div>
{/if}

{if $premium}
  <div class="crm-accordion-wrapper ">
    <div class="crm-accordion-header">
      {ts}Premium Information{/ts}
    </div>
    <div class="crm-accordion-body">
      <table class="crm-info-panel">
        <td class="label">{ts}Premium{/ts}</td>
        <td>{$premium}</td>
        <td class="label">{ts}Option{/ts}</td>
        <td>{$option}</td>
        <td class="label">{ts}Fulfilled{/ts}</td>
        <td>{$fulfilled|truncate:10:''|crmDate}</td>
      </table>
    </div>
  </div>
{/if}

{if $pcp_id}
  <div id='PCPView' class="crm-accordion-wrapper ">
    <div class="crm-accordion-header">
      {ts}Personal Campaign Page Contribution Information{/ts}
    </div>
    <div class="crm-accordion-body">
      <table class="crm-info-panel">
        <tr class="crm-contribute-contributionview-form-block-pcp_title">
          <td class="label">{ts}Personal Campaign Page{/ts}</td>
          <td><a href="{crmURL p="civicrm/pcp/info" q="reset=1&id=`$pcp_id`"}">{$pcp_title}</a><br/>
            <span class="description">{ts}Contribution was made through this personal campaign page.{/ts}</span>
          </td>
        </tr>
        <tr class="crm-contribute-contributionview-form-block-pcp_soft_credit_to_name">
          <td class="label">{ts}Soft Credit To{/ts}</td>
          <td><a href="{crmURL p="civicrm/contact/view" q="reset=1&cid=`$pcp_soft_credit_to_id`"}" id="view_contact"
                 title="{ts}View contact record{/ts}">{$pcp_soft_credit_to_name}</a></td>
        </tr>
        <tr class="crm-contribute-contributionview-form-block-pcp_display_in_roll">
          <td class="label">{ts}In Public Honor Roll?{/ts}</td>
          <td>{if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}</td>
        </tr>
        {if $pcp_roll_nickname}
          <tr class="crm-contribute-contributionview-form-block-pcp_roll_nickname">
            <td class="label">{ts}Honor Roll Name{/ts}</td>
            <td>{$pcp_roll_nickname}</td>
          </tr>
        {/if}
        {if $pcp_personal_note}
          <tr class="crm-contribute-contributionview-form-block-pcp_personal_note">
            <td class="label">{ts}Personal Note{/ts}</td>
            <td>{$pcp_personal_note}</td>
          </tr>
        {/if}
      </table>
    </div>
  </div>
{/if}

{include file="CRM/Custom/Page/CustomDataView.tpl"}

{if $billing_address}
  <fieldset>
    <legend>{ts}Billing Address{/ts}</legend>
    <div class="form-item">
      {$billing_address|nl2br}
    </div>
  </fieldset>
{/if}
{if $addRecordPayment}
  {include file="CRM/Contribute/Page/PaymentInfo.tpl" show='payments'}
{/if}

<div class="crm-submit-buttons">
  {if (call_user_func(array('CRM_Core_Permission','check'), 'edit contributions') && call_user_func(array('CRM_Core_Permission', 'check'), "edit contributions of type $financial_type") && $canEdit) ||
    	(call_user_func(array('CRM_Core_Permission','check'), 'edit contributions') && $noACL)}
    {assign var='urlParams' value="reset=1&id=$id&cid=$contact_id&action=update&context=$context"}
    {if ( $context eq 'fulltext' || $context eq 'search' ) && $searchKey}
      {assign var='urlParams' value="reset=1&id=$id&cid=$contact_id&action=update&context=$context&key=$searchKey"}
    {/if}
    <a class="button" href="{crmURL p='civicrm/contact/view/contribution' q=$urlParams}" accesskey="e"><span><i class="crm-i fa-pencil"></i> {ts}Edit{/ts}</span></a>
    {if $paymentButtonName}
      <a class="button" href='{crmURL p="civicrm/payment" q="action=add&reset=1&component=`$component`&id=`$id`&cid=`$contact_id`"}'><i class="crm-i fa-plus-circle"></i> {ts}{$paymentButtonName}{/ts}</a>
    {/if}
  {/if}
  {if (call_user_func(array('CRM_Core_Permission','check'), 'delete in CiviContribute') && call_user_func(array('CRM_Core_Permission', 'check'), "delete contributions of type $financial_type") && $canDelete)     || (call_user_func(array('CRM_Core_Permission','check'), 'delete in CiviContribute') && $noACL)}
    {assign var='urlParams' value="reset=1&id=$id&cid=$contact_id&action=delete&context=$context"}
    {if ( $context eq 'fulltext' || $context eq 'search' ) && $searchKey}
      {assign var='urlParams' value="reset=1&id=$id&cid=$contact_id&action=delete&context=$context&key=$searchKey"}
    {/if}
    <a class="button" href="{crmURL p='civicrm/contact/view/contribution' q=$urlParams}"><span><i class="crm-i fa-trash"></i> {ts}Delete{/ts}</span></a>
  {/if}
  {include file="CRM/common/formButtons.tpl" location="bottom"}
</div>
</div>
{crmScript file='js/crm.expandRow.js'}
